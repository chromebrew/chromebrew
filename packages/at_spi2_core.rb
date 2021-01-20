require 'package'

class At_spi2_core < Package
  description 'This is over DBus, tookit widgets provide their content to screen readers such as Orca'
  homepage 'http://www.freedesktop.org/'
  version '2.26.1'
  compatibility 'all'
  source_url 'https://github.com/GNOME/at-spi2-core/archive/AT_SPI2_CORE_2_26_1.tar.gz'
  source_sha256 '30cafdcce582cf7fc57d760ef36293344b8a29370f96b300ff56fe24cdb4a0a2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.26.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.26.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.26.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_core-2.26.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1ddf25b1d1c22517ecfcc571a5e674ea4ae9c371ceb8ad4f0959d928f8d5050e',
     armv7l: '1ddf25b1d1c22517ecfcc571a5e674ea4ae9c371ceb8ad4f0959d928f8d5050e',
       i686: '657e8745c754c86d2d217ee61b1303c8e369fde41ad456a0297270cdf32956c1',
     x86_64: '340e21fedd23e3a18f470512b6109aecd307722b1cfa56970e7c99a51aa2f7d1',
  })

  depends_on 'automake' => :build
  depends_on 'libxtst'
  depends_on 'dbus'
  depends_on 'glib'
  depends_on 'gobject_introspection'
  depends_on 'libxcb'
  depends_on 'gtk_doc'
  depends_on 'libtool'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
