require 'package'

class Libxpm < Package
  description 'X.org X Pixmap Library'
  homepage 'http://www.x.org'
  version '3.5.12'
  compatibility 'all'
  source_url 'https://www.x.org/archive//individual/lib/libXpm-3.5.12.tar.gz'
  source_sha256 '2523acc780eac01db5163267b36f5b94374bfb0de26fc0b5a7bee76649fd8501'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxpm-3.5.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxpm-3.5.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxpm-3.5.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxpm-3.5.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c38c518e3fd530ad13fd27dc67d5a14f5eb06b2a5259c38a321e80e02541a9e8',
     armv7l: 'c38c518e3fd530ad13fd27dc67d5a14f5eb06b2a5259c38a321e80e02541a9e8',
       i686: '2ea376f91f067e0191dafb7aad088ad1ed7408997e3384e8c820344fc2c0373f',
     x86_64: '8690186c140efb01a93ed7f0142a12d7e591ad7a336494ae0e9df44b754af239',
  })

  depends_on 'libx11'
  depends_on 'util_macros'
  depends_on 'gettext'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
