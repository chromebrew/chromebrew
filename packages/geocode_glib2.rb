require 'buildsystems/meson'

class Geocode_glib2 < Meson
  description 'Helper library for geocoding services'
  homepage 'https://gitlab.gnome.org/GNOME/geocode-glib'
  version '3.26.4'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/geocode-glib/-/archive/3.26.4/geocode-glib-3.26.4.tar.bz2'
  source_sha256 'b94b7cc015825b4ad64d293093f9881f1bab6837dd2500a88d12869264332e41'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb9343b3fdd5be728e673e91d6cf3f91e25418fd32aad29a92334df2ef69e3fc',
     armv7l: 'cb9343b3fdd5be728e673e91d6cf3f91e25418fd32aad29a92334df2ef69e3fc',
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

  gnome

  def self.patch
    system "sed -i 's/gnome/Adwaita/' icons/meson.build"
  end

  meson_options '-Dsoup2=false'

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    # Conficts with geocode_glib
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/icons"
  end
end
