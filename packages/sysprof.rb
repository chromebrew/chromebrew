# Adapted from Arch Linux sysprof PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/sysprof/trunk/PKGBUILD

require 'buildsystems/meson'

class Sysprof < Meson
  description 'Kernel based performance profiler'
  homepage 'https://wiki.gnome.org/Apps/Sysprof'
  version '50.0'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/sysprof.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac85b617989d653cf33a321511530a0375187ec36719f812f4144c0b237cc945',
     armv7l: 'ac85b617989d653cf33a321511530a0375187ec36719f812f4144c0b237cc945',
     x86_64: '49efa8cac1101a23ae2133907c0f311484342c157369d70253672f3699550ec8'
  })

  depends_on 'cairo' => :executable
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'graphene' => :executable
  depends_on 'gtk4' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'json_glib' => :library
  depends_on 'libadwaita' => :executable
  depends_on 'libdex' => :library
  depends_on 'libpanel' => :executable
  depends_on 'libunwind' => :library
  depends_on 'pango' => :executable
  depends_on 'polkit' => :library

  meson_options '-Dsysprofd=none \
                 -Dexamples=false \
                 -Dhelp=false \
                 -Dtests=false \
                 -Dtools=false'
end
