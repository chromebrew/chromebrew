require 'package'

class Sqlmap < Package
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'http://sqlmap.org/'
  version '1.4.2'
  source_url 'https://github.com/sqlmapproject/sqlmap/archive/1.4.2.tar.gz'
  source_sha256 '77faf85164eb17dce769ec830cbd146768644315bc1024613ad13155e09c2d11'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '02a1b56739af28c5c2dbd920f69c630e7e1ffafc043387b06534c9586886f5f7',
     armv7l: '02a1b56739af28c5c2dbd920f69c630e7e1ffafc043387b06534c9586886f5f7',
       i686: '0fbff386670b5ef09f12d3b3e3478d203f4f1140d529b039be36d7123399497e',
     x86_64: '886d073baae73b24d03dfdc8c7d09dff3de47eda9229794caed5a1915b25c588',
  })

  depends_on 'python27' unless File.exist? "#{CREW_PREFIX}/bin/python"

  def self.build
    system "echo '#!/bin/bash' > sqlmap"
    system "echo 'cd #{CREW_PREFIX}/share/sqlmap' >> sqlmap"
    system "echo 'python sqlmap.py -c sqlmap.conf \"\$@\"' >> sqlmap"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sqlmap"
    system "cp -r . #{CREW_DEST_PREFIX}/share/sqlmap"
    system "install -Dm755 sqlmap #{CREW_DEST_PREFIX}/bin/sqlmap"
  end

  def self.postinstall
    puts
    puts "To get extended help, run 'sqlmap -hh | most'".lightblue
    puts
    puts "To configure, edit #{CREW_PREFIX}/share/sqlmap/sqlmap.conf".lightblue
    puts
  end
end
