require 'package'

class Sqlmap < Package
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'http://sqlmap.org/'
  version '1.4.2'
  source_url 'https://github.com/sqlmapproject/sqlmap/archive/1.4.2.tar.gz'
  source_sha256 '77faf85164eb17dce769ec830cbd146768644315bc1024613ad13155e09c2d11'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

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
