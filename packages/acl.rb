require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.2.52'
  source_url 'http://download.savannah.gnu.org/releases/acl/acl-2.2.52.src.tar.gz'
  source_sha256 '179074bb0580c06c4b4137be4c5a92a701583277967acdb5546043c7874e0d23'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/acl-2.2.52-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/acl-2.2.52-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/acl-2.2.52-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/acl-2.2.52-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a5af9c618a1e8db3641b16b84680a852bbe9fa651b8097087b9b35279eb07a83',
     armv7l: 'a5af9c618a1e8db3641b16b84680a852bbe9fa651b8097087b9b35279eb07a83',
       i686: 'd12b8be543c92eb789d80abe09a84e8a9261410379bd23829d3dc7305aabe608',
     x86_64: 'c883356b00cfa258cb3e62f9af734ac2a951e9f50faa6b244736f5c03f5662e7',
  })

  depends_on 'attr'

  def self.build
    system './configure --prefix=/usr/local --libexecdir=/usr/local/lib --disable-static'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-dev"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-lib"
  end
end
