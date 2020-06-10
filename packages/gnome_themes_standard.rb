require 'package'

class Gnome_themes_standard < Package
  description 'Standard Themes for GNOME Applications.'
  homepage 'https://git.gnome.org/browse/gnome-themes-standard/'
  version '3.27.92-0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gnome-themes-extra/archive/3.27.92.tar.gz'
  source_sha256 'c2c2b02e6826d51de4e6e53afffbdb0ec301ef776df91944574fdc42b558cecb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_themes_standard-3.27.92-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_themes_standard-3.27.92-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_themes_standard-3.27.92-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_themes_standard-3.27.92-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6c77323e31792cbf70f48a109280b9e1a8a225b1deade3de620a0624a372dc43',
     armv7l: '6c77323e31792cbf70f48a109280b9e1a8a225b1deade3de620a0624a372dc43',
       i686: '92611d2b331fc3862cf7bec369dfcd1854fa25335b36b75c54965cdaa55997cf',
     x86_64: 'd9771b38d88749626f0a7da9d66a43bd5c8e71df6eac868e90343f2bc994c22d',
  })

  depends_on 'gtk3'
  depends_on 'gtk2'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'
  depends_on 'gnome_common'

  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
