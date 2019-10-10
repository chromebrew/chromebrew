require 'package'

class Sublime_text < Package
  description 'A sophisticated text editor for code, markup and prose.'
  homepage 'https://www.sublimetext.com/'
  version '3.2.2'
  case ARCH
  when 'x86_64'		  
    source_url 'https://download.sublimetext.com/sublime_text_3_build_3211_x64.tar.bz2'
    source_sha256 '0b3c8ca5e6df376c3c24a4b9ac2e3b391333f73b229bc6e87d0b4a5f636d74ee'
  when 'i686'
    source_url 'https://download.sublimetext.com/sublime_text_3_build_3211_x32.tar.bz2'
    source_sha256 '480609962bbbd12128b5332c7831372b8851c13e160512730d1b0a6a835a3071'
  end
  
  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk2'
  depends_on 'sommelier'

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/share/sublime_text"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/bin"
    system "cp", "-rpa", ".", "#{CREW_DEST_PREFIX}/share/sublime_text/"
    system "ln", "-s", "#{CREW_PREFIX}/share/sublime_text/sublime_text", "#{CREW_DEST_PREFIX}/bin/sublime_text"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed Sublime Text on Chrome OS!'.lightgreen
    puts 'Now, please run \'sublime_text\' to start Sublime Text.'.lightgreen
    puts
  end
end
