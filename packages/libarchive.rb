require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'http://www.libarchive.org/'
  version '3.2.2'
  source_url 'http://www.libarchive.org/downloads/libarchive-3.2.2.tar.gz'
  source_sha256 '691c194ee132d1f0f7a42541f091db811bc2e56f7107e9121be2bc8c04f1060f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libarchive-3.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libarchive-3.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libarchive-3.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libarchive-3.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2dde0581548d00cb3df09232daa5dc4f62a310537385afdbe7710d452b63c1fb',
     armv7l: '2dde0581548d00cb3df09232daa5dc4f62a310537385afdbe7710d452b63c1fb',
       i686: '80a0e5dac82fd52f60e8dbf6f5130e865888b0e50fb028efd485f28f8e4f81ec',
     x86_64: 'df7b464068f21919d6fc9a5afa782713b2533bc345a60f1be44944af67f718c4',
  })

  depends_on 'acl'
  depends_on 'attr'
  depends_on 'lz4'

  def self.build
    system "./configure --prefix=/usr/local --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
