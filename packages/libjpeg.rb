require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'http://www.ijg.org/'
  version '9.0-c'
  source_url 'http://www.ijg.org/files/jpegsrc.v9c.tar.gz'
  source_sha256 '1f3a3f610f57e88ff3f1f9db530c605f3949ee6e78002552e324d493cf086ad4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-c-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-c-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-c-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg-9.0-c-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '46d6bf16c5b1cc601bbf7c81de56b8451ccfe15b8660a0f61a5dc882e8f68dec',
     armv7l: '46d6bf16c5b1cc601bbf7c81de56b8451ccfe15b8660a0f61a5dc882e8f68dec',
       i686: 'a1afb706120d5396f34536e8613e0a1c81e927d8d0dbc6d910e03563dd1be029',
     x86_64: 'd60d7686e7f8b5808bc5f96518da10061c507d0f1da59021d2869ff1662432b6',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
