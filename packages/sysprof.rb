# Adapted from Arch Linux sysprof PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/sysprof/trunk/PKGBUILD

require 'buildsystems/meson'

class Sysprof < Meson
  description 'Kernel based performance profiler'
  homepage 'https://wiki.gnome.org/Apps/Sysprof'
  version '51.0'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/sysprof.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c44d4376c7cd190e875b77004a73843a205e63c16aaca7eb6dd97a9ea5f5a4b',
     armv7l: '7c44d4376c7cd190e875b77004a73843a205e63c16aaca7eb6dd97a9ea5f5a4b',
     x86_64: 'cef7fadb225161966a4d861add36b7f0b8c689fc2f19a5289bed654a8cc97855'
  })

  depends_on 'cairo' => :executable
  depends_on 'desktop_file_utils' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
