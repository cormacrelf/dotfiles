-- counts words in a document
-- originally from pandoc/lua-filters, adapted for pandoc-citeproc

function Note(el)
  return {}
end

-- skip the @part
function Cite(el)
  return el.content
end

-- suppress citeproc's generated bibliography (div id=refs)
function Div(el)
  if el.attr.identifier == "refs" then
    return {}
  end
  -- if el.classes[1] == "comment" then
  --   return {}
  -- end
  if el.classes[1] == "not-counted" then
    return {}
  end
  return el
end

-- suppress #refs header
function Header(el)
  if el.attr.identifier == "refs" then
    return {}
  end
  return el
end

words = 0

wordcount = {
  Str = function(el)
    -- we don't count a word if it's entirely punctuation:
    if el.text:match("%P") then
      words = words + 1
    end
  end,

  Code = function(el)
    _,n = el.text:gsub("%S+","")
    words = words + n
  end,

  CodeBlock = function(el)
    _,n = el.text:gsub("%S+","")
    words = words + n
  end
}

function Pandoc(el)
    -- skip metadata, just count body:
    pandoc.walk_block(pandoc.Div(el.blocks), wordcount)
    print(words)
    os.exit(0)
end
