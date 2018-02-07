require 'package'

class At_spi2_atk < Package
  description 'D-Bus AT-SPI'
  homepage 'http://www.freedesktop.org/'
  version '2.26.1'
  source_url 'https://github.com/GNOME/at-spi2-atk/archive/AT_SPI2_ATK_2_26_1.tar.gz'
  source_sha256 '45fc52f794c785d54d6e2689f51ade043c96ea0263f6113c1ce26df1ef26af5b'
  
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
