require 'buildsystems/meson'

class Gjs < Meson
  description 'Javascript Bindings for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/gjs/'
  version "1.89.2-#{CREW_ICU_VER}"
  license 'MIT and MPL-1.1, LGPL-2+ or GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gjs.git'
  git_hashtag version.split('-')[0]
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '895b50bd856c88a30a5c681180eb721e4de656cd717d28d30ddc7d36b5f91eeb',
     armv7l: '895b50bd856c88a30a5c681180eb721e4de656cd717d28d30ddc7d36b5f91eeb',
     x86_64: '60622d1a299e00b8e9fc6a00fbd27a49659d2a10f8358018208a665e808895d1'
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
