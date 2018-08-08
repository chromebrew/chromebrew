require 'package'

class At_spi2_atk < Package
  description 'D-Bus AT-SPI'
  homepage 'http://www.freedesktop.org/'
  version '2.26.2'
  source_url 'https://github.com/GNOME/at-spi2-atk/archive/AT_SPI2_ATK_2_26_2.tar.gz'
  source_sha256 'f1810e5ec196dac1b126c530342b300790cbb6da38f5969d82fee23b45264fb0'

  binary_url ({
  })
  binary_sha256 ({
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
