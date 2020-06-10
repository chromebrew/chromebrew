require 'package'

class At_spi2_atk < Package
  description 'D-Bus AT-SPI'
  homepage 'http://www.freedesktop.org/'
  version '2.26.1'
  compatibility 'all'
  source_url 'https://github.com/GNOME/at-spi2-atk/archive/AT_SPI2_ATK_2_26_1.tar.gz'
  source_sha256 '45fc52f794c785d54d6e2689f51ade043c96ea0263f6113c1ce26df1ef26af5b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.26.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.26.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.26.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.26.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e72e7b89903b2361b55065beefa639904ae880741fbc64b1914ee9fd596a1a8',
     armv7l: '4e72e7b89903b2361b55065beefa639904ae880741fbc64b1914ee9fd596a1a8',
       i686: '165854bff7a99fcfaf7a807e41eaa6d889c10998250f0c706dcb9eee3d198aba',
     x86_64: '01c66589188a81499b7ac4424f937f3adbe7265bb1c55d8d0d8746df8d302061',
  })
  
  depends_on 'automake' => :build
  depends_on 'at_spi2_core'  
  depends_on 'atk'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
