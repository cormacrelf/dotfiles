require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do
  linkables = Dir.glob('*/**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end

  def manual_symlink(relpath, targetname)
    target = "#{ENV["HOME"]}/" + targetname
    write = false
    if File.exists?(target) || File.symlink?(target)
      print "overwrite ~/#{targetname}? type yes: "
      input = STDIN.gets.chomp
      if input == "yes"
        FileUtils.rm_rf(target) 
        write = true
      end
    else
      write = true
    end
    `ln -s "$PWD/#{relpath}" #{target}` if write
  end

  manual_symlink "vim/vim.symlink/vimrc.vim", ".vimrc"
  manual_symlink "vim/vim.symlink/gvimrc.vim", ".gvimrc"
  manual_symlink "vim/vim.symlink", ".config/nvim"

  pandoc_templates = Dir.glob("./pandoc/templates/*")

  skip_all = false
  overwrite_all = false
  backup_all = false

  puts "Enter the directory for pandoc templates. If you don't want to install them, just hit enter."
  target_dir = gets.chomp

  if target_dir != "" 
    pandoc_templates.each do |template|
      overwrite = false
      backup = false

      file = template.split('/').last
      target = target_dir + "/" + "#{file}"

      if File.exists?(target) || File.symlink?(target)
        unless skip_all || overwrite_all || backup_all
          puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
          case STDIN.gets.chomp
          when 'o' then overwrite = true
          when 'b' then backup = true
          when 'O' then overwrite_all = true
          when 'B' then backup_all = true
          when 'S' then skip_all = true
          when 's' then next
          end
        end
        FileUtils.rm_rf(target) if overwrite || overwrite_all
        `mv "#{target_dir}/#{file}" "#{target_dir}/#{file}.backup"` if backup || backup_all
      end
      `ln -s "$PWD/#{template}" "#{target}"`
    end
  end
  
end

task :uninstall do

  Dir.glob('**/*.symlink').each do |linkable|

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end
    
    # Replace any backups made during installation
    if File.exists?("#{ENV["HOME"]}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"` 
    end

  end
end

task :brew do
  puts "Are you sure? Building/installing all this might take a while."
  reply = STDIN.gets.chomp.downcase
  `/bin/sh homebrew/brew.sh` if reply == "y" or reply == "yes"
end

task :default => 'install'
