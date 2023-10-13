require 'package'

class Geocode_glib2 < Package
  description 'Helper library for geocoding services'
  homepage 'https://gitlab.gnome.org/GNOME/geocode-glib'
  version '3.26.4'
  license 'LGPL-2'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/geocode-glib/-/archive/3.26.4/geocode-glib-3.26.4.tar.bz2'
  source_sha256 'b94b7cc015825b4ad64d293093f9881f1bab6837dd2500a88d12869264332e41'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib2/3.26.4_armv7l/geocode_glib2-3.26.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib2/3.26.4_armv7l/geocode_glib2-3.26.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib2/3.26.4_i686/geocode_glib2-3.26.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/geocode_glib2/3.26.4_x86_64/geocode_glib2-3.26.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cb9343b3fdd5be728e673e91d6cf3f91e25418fd32aad29a92334df2ef69e3fc',
     armv7l: 'cb9343b3fdd5be728e673e91d6cf3f91e25418fd32aad29a92334df2ef69e3fc',
       i686: '9aa73a48a884e62ea5c1428670bcaa7564a192f7f5d40142d89a51694348d1ff',
     x86_64: '391362270a3104e5cfbc1a7fc96d8faada59d4d262f1d6dcc74c034136465456'
  })

  depends_on 'json_glib'
  depends_on 'libsoup'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'py3_pygments' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.patch
    system "sed -i 's/gnome/Adwaita/' icons/meson.build"
  end

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dsoup2=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    # Conficts with geocode_glib
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/icons"
  end
end
