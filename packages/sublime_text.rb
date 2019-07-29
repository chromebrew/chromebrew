require 'package'

class Sublime_text < Package
  description 'A sophisticated text editor for code, markup and prose.'
  homepage 'https://www.sublimetext.com/'
  version '3.2'
  case ARCH
  when 'x86_64'		  
    source_url 'https://download.sublimetext.com/sublime_text_3_build_3200_x64.tar.bz2'
    source_sha256 'b9d5297c65bd14a8ba3394e74dbd9a5013b3fed5a5a2f8f5120d2cec40614fbd'
  when 'i686'
    source_url 'https://download.sublimetext.com/sublime_text_3_build_3200_x32.tar.bz2'
    source_sha256 'f94772aa6313f228a930ae85573bb18411e96c60c3c14027e9c27c14e5aa7906'
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
