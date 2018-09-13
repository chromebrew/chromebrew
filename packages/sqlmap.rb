require 'package'

class Sqlmap < Package
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'http://sqlmap.org/'
  version '1.2'
  source_url 'https://github.com/sqlmapproject/sqlmap/archive/1.2.tar.gz'
  source_sha256 '39e0ef58365a5a0413d88dfcc0d1c210b465661cb97c8e5b42c1feba791d2453'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlmap-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '973af18d7883218b102c9f2d0c87b9a393951eb7a0935ce2de495221311b8c57',
     armv7l: '973af18d7883218b102c9f2d0c87b9a393951eb7a0935ce2de495221311b8c57',
       i686: 'b924ba5594a1b6c35a023446499c4b4775d17baacbbdab990a34f58da50817d1',
     x86_64: 'a4bf8317eb465acdf4bc743d6fddc838b16de909144cfa5706f6fbc45d942e7e',
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
