class Main
  $a = Hash.new
  $full = File.expand_path(Dir.getwd)
end

  def searchDir(dir)
    if dir.size == 0
      return true
    end

    $a.store(dir, true)
    Dir.chdir(dir)
    Dir['*'].sort.each do |item|
      if File.directory?(item)
        #if it's a directory we haven't search, recurse on it
        searchDir(dir+"/"+item)
      elsif File.file?(item)
        if File.extname(item).eql?('.html')
          puts "Found an HTML file"
        end
      end
    end
    
    if $full.size != 0
      $full = $full[0, $full.rindex('/')]
      searchDir($full)
    else
      return true
    end
  end

  if (searchDir($full)) == true
    puts "Search complete"
  end