require 'package'

class Projectlibre < Package
  description 'ProjectLibre is project management software, the leading alternative to Microsoft Project.'
  homepage 'https://www.projectlibre.com/'
  version '1.9.1'
  source_url 'https://downloads.sourceforge.net/project/projectlibre/ProjectLibre/1.9.1/projectlibre-1.9.1.tar.gz'
  source_sha256 '65ca96728eb5a31c3e23eb43181dde367d785a86b82f330ca52bc7b51c74a5bb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/projectlibre-1.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/projectlibre-1.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/projectlibre-1.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/projectlibre-1.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f7df4bbee8466e6cfffd9c4e22f5982c1762abeebf699732ea114b9fa9daf5a6',
     armv7l: 'f7df4bbee8466e6cfffd9c4e22f5982c1762abeebf699732ea114b9fa9daf5a6',
       i686: 'd7267d23309e7f0459caec003453024680c08a94ed81033b9624ab4867eb1b87',
     x86_64: '004464a19153c20ace590a7077cbadf3be558b9a107fa581346507d98cfd2df8',
  })

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.install
    FileUtils.rm 'projectlibre.bat'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/projectlibre"
    FileUtils.cp_r Dir.glob('.'), "#{CREW_DEST_PREFIX}/share/projectlibre"
    system "cat << 'EOF' > projectlibre
#!/bin/bash
cd #{CREW_PREFIX}/share/projectlibre
./projectlibre.sh
EOF"
    system "install -Dm755 projectlibre #{CREW_DEST_PREFIX}/bin/projectlibre"
  end

  def self.postinstall
    puts
    puts "To get started, execute 'projectlibre'".lightblue
    puts
  end
end
