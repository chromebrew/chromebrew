require 'package'

class Sublime_text < Package
  description 'A sophisticated text editor for code, markup and prose.'
  homepage 'https://www.sublimetext.com/'
  version '3.1.1'
  case ARCH
  when 'x86_64'		  
    source_url 'https://download.sublimetext.com/sublime_text_3_build_3176_x64.tar.bz2'
    source_sha256 '74f17c1aec4ddec9d4d4c39f5aec0414a4755d407a05efa571e8892e0b9cf732'
  when 'i686'
    source_url 'https://download.sublimetext.com/sublime_text_3_build_3176_x32.tar.bz2'
    source_sha256 '43e49dfdbea61cc0a1b6ebcdf0ff522d8531e6998e05f4756ba4218446f85a21'
  end
  
  binary_url ({
  })
  binary_sha256 ({
  })

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
