require 'package'

class Libdmx < Package
  description 'X.org X Window System DMX (Distributed Multihead X) extension library'
  homepage 'http://www.x.org'
  version '1.1.3'
  source_url 'https://www.x.org/archive/individual/lib/libdmx-1.1.3.tar.gz'
  source_sha256 'c4b24d7e13e5a67ead7a18f0b4cc9b7b5363c9d04cd01b83b5122ff92b3b4996'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libdmx-1.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78e8c7ea5d24310a372b6162d1ed559a52e7cb9886f3f76b36d7ff79f0c923f2',
     armv7l: '78e8c7ea5d24310a372b6162d1ed559a52e7cb9886f3f76b36d7ff79f0c923f2',
       i686: '021346d67ea742eaa4bb33e972bd8d428f08441b7d222f9154f6ca2321eb6a6f',
     x86_64: '947c4cef27723aeb3bdebbdf2430b3282399c5bfa3001d0f733a07cf53623829',
  })

  depends_on 'xextproto'
  depends_on 'dmxproto'
  depends_on 'libxext'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end