require 'package'

class Sublime_merge < Package
  description 'A snappy UI, three-way merge tool,side-by-side diffs, syntax highlighting, and more.'
  homepage 'https://www.sublimemerge.com/'
  version 'Build 1065'
  case ARCH
  when 'x86_64'		  
	source_url 'https://download.sublimetext.com/sublime_merge_build_1065_x64.tar.xz'
	source_sha256 'ebe9029ea71543a101dcfd09c5540759759c1e33fea31d4b98256803b7ceaf97'
  end
  
  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'sommelier'

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/share/sublime_merge"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
    system "cp", "-rpa", ".", "#{CREW_DEST_PREFIX}/share/sublime_merge/"
    system "ln", "-s", "#{CREW_PREFIX}/share/sublime_merge/sublime_merge", "#{CREW_DEST_PREFIX}/bin/sublime_merge"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed Sublime Merge on Chrome OS!'.lightgreen
    puts 'Now, please run \'sublime_merge\' to start Sublime Merge.'.lightgreen
    puts
  end
end
