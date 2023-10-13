require 'package'

class Json_glib < Package
  description 'JSON-GLib implements a full suite of JSON-related tools using GLib and GObject.'
  homepage 'https://wiki.gnome.org/Projects/JsonGlib'
  version '1.6.6'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/json-glib.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/json_glib/1.6.6_armv7l/json_glib-1.6.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/json_glib/1.6.6_armv7l/json_glib-1.6.6-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/json_glib/1.6.6_i686/json_glib-1.6.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/json_glib/1.6.6_x86_64/json_glib-1.6.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '37724d89adff90c65166c4f9f908bd1f4184ed5422caea9ec31fab941abbc947',
     armv7l: '37724d89adff90c65166c4f9f908bd1f4184ed5422caea9ec31fab941abbc947',
       i686: '08a05f309d75ee639cc009973f03de5018d6306080d6feac96a3792597eb348c',
     x86_64: '40a0670356d43d4154b89ea2d0543b9db01b5920bc04b8d144d56a1de78d418c'
  })

  depends_on 'gtk_doc'
  depends_on 'glib'
  depends_on 'gobject_introspection'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja test -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
