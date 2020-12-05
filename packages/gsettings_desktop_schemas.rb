require 'package'

class Gsettings_desktop_schemas < Package
  description 'Collection of GSettings schemas for GNOME desktop.'
  homepage 'https://git.gnome.org/browse/gsettings-desktop-schemas'
  version '3.38.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/gsettings-desktop-schemas/archive/3.38.0.tar.gz'
  source_sha256 'b808bd285ac7176f2e9e3a8763c3913121ab9f109d2988c70e3f1f8e742a630d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.38.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.38.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.38.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gsettings_desktop_schemas-3.38.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dd97405ae148e26b65dfce4f91711dd73c54a021fc8d1f3463c9af30c1874d82',
     armv7l: 'dd97405ae148e26b65dfce4f91711dd73c54a021fc8d1f3463c9af30c1874d82',
       i686: '87eb145275e5d3c3bbb2042b6dd0bfd334012d3665b086dd1c4c722d10510287',
     x86_64: '69e40284e42d687b48fd5c35ef84d695a94ba0e8483ce2cb0654cc07886a177b',
  })

  depends_on 'gnome_common'
  depends_on 'glib'
  depends_on 'gobject_introspection'

  def self.build
    system "sed -i -r 's:\"(/system):\"/org/gnome\1:g' schemas/*.in"
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end

end
