require 'buildsystems/meson'

class Gjs < Meson
  description 'Javascript Bindings for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/gjs/'
  version "1.89.1-#{CREW_ICU_VER}"
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag version.split('-')[0]
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3adc79bdadfa32591555508f1481963163a234ce6a04372ca8022b95e24059a5',
     armv7l: '3adc79bdadfa32591555508f1481963163a234ce6a04372ca8022b95e24059a5',
     x86_64: '72e8f395073af3168fc3f7c3836ed6f783addaa352cc1ea25f23709f96676415'
  })

  depends_on 'cairo' => :library
  depends_on 'dbus' => :build
  depends_on 'dconf' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk4' => :build
  depends_on 'harfbuzz' # R
  depends_on 'js140' => :library
  depends_on 'libffi' => :library
  depends_on 'libx11' => :library

  gnome

  meson_options '-Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dskip_gtk_tests=true \
    -Dprofiler=disabled \
    -Dreadline=disabled'

  def self.patch
    # Remove SpiderMonkey sanity check.
    system "sed -i '299,315d' meson.build"
  end
end
