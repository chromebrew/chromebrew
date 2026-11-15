require 'buildsystems/meson'

class Gnome_autoar < Meson
  description 'Automatic archives creating and extracting library'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-autoar'
  version '0.5.2'
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-autoar.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f91d3a595b692458f33eb5d98da6d58680feee6b10aaede69baa593878c9da48',
     armv7l: 'f91d3a595b692458f33eb5d98da6d58680feee6b10aaede69baa593878c9da48',
     x86_64: '71e1775c0cf550abf22b0b624046fff67c278f0c98c9f5727c4d9150cd06aba2'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'cairo' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :library
  depends_on 'gtk_doc' => :build
  depends_on 'libarchive' => :library
  depends_on 'libjpeg_turbo' => :build
  depends_on 'vala' => :build

  gnome
end
