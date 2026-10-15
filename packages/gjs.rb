require 'buildsystems/meson'

class Gjs < Meson
  description 'Javascript Bindings for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/gjs/'
  version "1.90.1-#{CREW_ICU_VER}"
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag version.split('-')[0]
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '476bc5abee64f8bab9d319a3d9a747dd8a7a17f8d2e0247652feb0aaf3c28291',
     armv7l: '476bc5abee64f8bab9d319a3d9a747dd8a7a17f8d2e0247652feb0aaf3c28291',
     x86_64: 'fa708cd34623d60eba66714c6880b39dd161eed2ecaeece65f22a4cd80bbc388'
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
