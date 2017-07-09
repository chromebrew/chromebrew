require 'package'

class Rsync < Package
  description 'rsync is an open source utility that provides fast incremental file transfer.'
  homepage 'https://rsync.samba.org/'
  version '3.1.2'
  source_url 'http://rsync.samba.org/ftp/rsync/src/rsync-3.1.2.tar.gz'
  source_sha256 'ecfa62a7fa3c4c18b9eccd8c16eaddee4bd308a76ea50b5c02a5840f09c0a1c2'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/rsync-3.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/rsync-3.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/rsync-3.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/rsync-3.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '400010ac92e997d88815e950811c78a5f193333676dfe3b26787ab01b66906a0',
     armv7l: '400010ac92e997d88815e950811c78a5f193333676dfe3b26787ab01b66906a0',
       i686: '9e7c37686b5b5a1a4c7b4fbf2c93da29eb465de49e74f67c25408b2b28655311',
     x86_64: '93135332086e1db3f21a10c29498b3d6aac4ea540a54e79bd723c8512bbbeb18',
  })

  depends_on 'buildessential'
  depends_on 'perl' => :build

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
