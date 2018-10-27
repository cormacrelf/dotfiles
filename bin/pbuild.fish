#!/usr/bin/env fish
set DOTFILES "$HOME/.dotfiles"

set pbuild (basename (status -f))

function sub_help
    echo "Usage: $pbuild <subcommand> <file.md>"
    echo "Subcommands:"
    # sub_short
    echo "    short   Build a plain document with small headers."
    echo "            -a | --append-bibliography => includes a bibliography at the end"
    # sub_json
    echo "    json    Raw pandoc syntax output. Useful for debugging lua filters"
    # sub_count
    echo "    count   Word count without generated footnotes from pandoc-citeproc."
    # sub_tex
    echo "    tex     Same as short, but only output generated latex."
    # sub_word
    echo "    word    Build a Word document."
    echo "            -r | --reference-doc => change styles"
    echo "            bootstrap styles:"
    echo "                create a feature-rich filler template.md"
    echo "                \$ pbuild word template.md"
    echo "                edit the styles in that document"
    echo "                \$ pbuild word real-doc.md -r template.docx"
end

###############################
########## Constants ##########
###############################

set DEBUG_OUT "/dev/null"
set -g OPEN 0
set -g OVERRIDE_OUTPUT

# Location of Pandoc support files.
set PREFIX "$HOME/.pandoc"

# Location of your working bibliography file
set BIB "--bibliography $HOME/lib/zotero-library.bib"

# CSL stylesheet (located in the csl folder of the PREFIX directory).
set CSL ""
set AGLC "$HOME/Zotero/styles/australian-guide-to-legal-citation.csl"
test -s "$AGLC"; and set CSL "--csl $AGLC"
set SUPPRESS_BIB "--metadata suppress-bibliography=true"

# Latex engine
set ENGINE "xelatex"

# Latex Template
set TEMPLATE "default.latex"
set MODERNTEMPLATE "$PREFIX/templates/xelatex-modern.template"
set LONGTEMPLATE "$PREFIX/kjhealy/xelatex.template"

# For word docs
set REFERENCE_DOC "--reference-doc $DOTFILES/pandoc/yale-law-journal.docx" # default location is $PREFIX/reference.docx, override with pbuild --reference-docx <loc>

# Markdown Extensions
set EXTENSIONS "+smart+citations+simple_tables+pipe_tables+table_captions+yaml_metadata_block+fenced_code_blocks+fancy_lists+startnum+example_lists+line_blocks+footnotes+inline_notes+inline_code_attributes+superscript+subscript+tex_math_dollars+raw_tex" 
# Short doc arguments. Override with env variables.
# (note that `: ${var=value}` sets var iff not already set.)

###############################
########## Commands ###########
###############################

# args -> produce $argv = files, $PANDOC_ARGV = rest {{{
set -g pbuild_argv
set -g PANDOC_ARGV

# split on --
set -g counter 1
for arg in $argv
  set counter (math $counter + 1)
  if test "$arg" != "--"
    set pbuild_argv $pbuild_argv "$arg"
  else
    set PANDOC_ARGV $argv[$counter..-1]
    break
  end
end

# GLOBAL args
set flags 'h/help' 'O/open' 'o/output=' 'V/verbose' 'c/csl=' 'b/bib=' 'v/variable=+'
set flags $flags 'r/reference-doc=' 'a-append-bibliography'
set flags $flags 'g/aglc-headers'
set -l $argv
argparse "--name=$pbuild" "--min-args=1" $flags -- $pbuild_argv
if test $status -ne 0
  echo
  sub_help
  exit
end
set -g SUBCOMMAND $argv[1]
set -g REST $argv[2..-1]

# flags handling {{{

set -g AGLC_HEADERS

if set -q _flag_help;
  sub_help
  exit 0;
end
if set -q _flag_open
  set OPEN 1
end
if set -q _flag_output
  set OVERRIDE_OUTPUT "$_flag_output"
end
if set -q _flag_verbose
  set DEBUG_OUT /dev/stderr
end
if set -q _flag_csl
  set CSL "--csl $_flag_csl"
end
if set -q _flag_bib
  set BIB "--bib $_flag_bib"
end
if set -q _flag_reference_doc
  set REFERENCE_DOC "--reference-doc '$_flag_r'"
end
if set -q _flag_append_bibliography;
  set SUPPRESS_BIB "--metadata suppress-bibliography=false"
end
if set -q _flag_aglc_headers;
  set AGLC_HEADERS "--lua-filter=$DOTFILES/pandoc/filters/aglc-headers.lua"
end

# }}}
# -v variable:value {{{

set -g variables $_flag_variable
set -g var_names
set -g var_values

function add_var
  set var_names $var_names $argv[1]
  set var_values $var_values $argv[2]
end

function set_var
  if set -l index (contains -i -- $argv[1] $var_names)
    set var_values[$index] $argv[2]
  else
    add_var $argv
  end
end

function get_var
  set -l key $argv[1]
  if set -l index (contains -i -- $key $var_names)
    echo "--variable=\"$key:$var_values[$index]\""
  end
end

add_var geometry 'a4paper,top=3cm,bottom=3cm,left=3cm,right=3cm'
add_var papersize 'a4paper'
add_var mainfont 'EB Garamond'
add_var sansfont 'Helvetica'
add_var monofont 'Fira Code'
add_var fontsize '12pt'
add_var linespace '1.24' # ~1.4 spaced (1.6 = double)
add_var parindent '0pt'
add_var parskip '10pt'
add_var linkcolor '[HTML]{4d98ff}'
add_var citecolor '[HTML]{4d98ff}'
add_var urlcolor '[HTML]{4d98ff}'

for var in $variables
  set_var (string split ':' $var)
end

function all_args
  for var in $var_names
    echo (get_var $var)
  end
end

function make_shortargs
  echo "--pdf-engine=$ENGINE --template=default" (all_args) "--highlight-style=haddock"
end
# }}}

# }}}

# subcommands {{{

set -g INPUT
set -g OUTPUT

set -g PANDOC_CMD "pandoc $BIB $SUPPRESS_BIB -r markdown$EXTENSIONS -s $CSL"

function pb_common
  set -l cmd "$PANDOC_CMD $argv $INPUT $PANDOC_ARGV"
  echo $cmd | tee $DEBUG_OUT | bash
  if test $status -eq 0; and test $OPEN -eq 1
    open $OUTPUT
  end
  return $status
end

function sub_json
  set -l cmd "$PANDOC_CMD $INPUT -t json $PANDOC_ARGV"
  echo $cmd | tee $DEBUG_OUT | bash
  return $status
end

function sub_count
  set -l cmd "$PANDOC_CMD $INPUT --lua-filter=$DOTFILES/pandoc/filters/wordcount.lua $PANDOC_ARGV"
  echo $cmd | bash 2>/dev/null
  return $status
end

function sub_short
  set -g OUTPUT (change_ext "$INPUT" pdf)
  pb_common "--template=default" (make_shortargs) "$AGLC_HEADERS -o $OUTPUT"
  return $status
end

function sub_word
  set -g OUTPUT (change_ext "$INPUT" docx)
  pb_common "$REFERENCE_DOC $AGLC_HEADERS -o $OUTPUT"
  return $status
end

function sub_tex
  set -g OUTPUT (change_ext "$INPUT" tex)
  set -l args 
  pb_common (make_shortargs)" -t latex -o $OUTPUT"
  return $status
end

function change_ext
  if test -n "$OVERRIDE_OUTPUT"
    echo "$OVERRIDE_OUTPUT"
  else
    echo (echo $argv[1] | cut -f 1 -d .)".$argv[2]"
  end
end

function foreach_file
  set -l error 0
  if test (count $REST) -gt 1
    echo "does not support more than one file at once"
    exit 1
  end
  for file in $REST
    set INPUT "$file"
    eval "sub_$SUBCOMMAND $file"
    set ret $status
    if test $ret -ne 0
      return $ret
    end
    break
  end
end

foreach_file

if test $status -eq 127
  echo "Error: '$SUBCOMMAND' is not a known subcommand."# >&2
  echo "Run '$pbuild --help' for a list of known subcommands."# >&2
  exit 1
end

exit $status
