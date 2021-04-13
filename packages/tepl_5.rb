require 'package'

class Tepl_5 < Package
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://wiki.gnome.org/Projects/Tepl'
  version '5.0.1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/GNOME/tepl/archive/5.0.1.tar.gz'
  source_sha256 '2dda3ed2bd16742f6d0fc6d602448eaa2e40b9c967b88599add2338d6fa590e7'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tepl_5-5.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/tepl_5-5.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/tepl_5-5.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/tepl_5-5.0.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '1c6bda4f08ad49244dd0e368858e43de9323adf54ab34d387754d0982a8af710',
     armv7l: '1c6bda4f08ad49244dd0e368858e43de9323adf54ab34d387754d0982a8af710',
       i686: '380fcc1fba9345a966726985dd7232d5bf1326bf62597f43b2bd194a40ce4a91',
     x86_64: 'd41156324372ef2d95d056a4b58d10f177bd9c1cf176f5c5baafdc81b55d2c1a'
  })

  depends_on 'amtk'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
