class Main
  $a = Hash.new
  $i = 0
  $b = ["a.html", "b.html", "c.html", "d.html", "e.html", "f.html", "g.html", "h.html", "i.html", "j.html", "k.html", "z.html", "v.html", "y.html"]
  $full = File.expand_path(Dir.getwd)
end

  def searchDir(dir)
    if dir.size == 0
      return true
    end

    $a.store(dir, true)
    Dir.chdir(dir)
    Dir['*'].sort.each do |item|
      if File.directory?(item) && !$a.has_key?(dir+"/"+item)
        #if it's a directory we haven't search, recurse on it
        searchDir(dir+"/"+item)
      elsif File.file?(item)
        if File.extname(item).eql?('.html')
          File.rename(item, $b[$i])
          $i += 1
        end
      end
    end
    
    if $full.size != 0
      $full = $full[0, $full.rindex('/')]
    dir = $full
      searchDir($full)
    else
      return true
    end
  end

  if (searchDir($full)) == true
    puts "Search complete"
  end