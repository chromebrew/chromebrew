require 'package'

class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.26.1'
  source_url 'https://github.com/GNOME/at-spi2-core/archive/AT_SPI2_CORE_2_26_1.tar.gz'
  source_sha256 '30cafdcce582cf7fc57d760ef36293344b8a29370f96b300ff56fe24cdb4a0a2'

  depends_on 'automake' => :build
  depends_on 'libxtst'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  
  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
