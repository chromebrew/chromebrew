require 'package'

class Libxcomposite < Package
  description 'X.org X Composite Library'
  homepage 'http://www.x.org'
  @_ver = '0.4.5'
  version @_ver
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXcomposite-#{@_ver}.tar.gz"
  source_sha256 '581c7fc0f41a99af38b1c36b9be64bc13ef3f60091cd3f01105bbc7c01617d6c'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.5-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.5-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.5-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcomposite-0.4.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '94f0c3ec1608749c8c03ce9dfeffb5f90421d8efa0b1a7796aede9844ba4adca',
      armv7l: '94f0c3ec1608749c8c03ce9dfeffb5f90421d8efa0b1a7796aede9844ba4adca',
        i686: 'c7a412b0f9e38f95eb6e5170c716567052fa3f957c507245a04d4dbcd9a7d221',
      x86_64: 'b5ccdd7144491356a9dedd71f6f94b8610ff2c1d475b29e0ee20a509010a17e4',
  })

  depends_on 'libxfixes'
  depends_on 'libxext'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.check
    system 'make', 'check'
  end
end
