require 'buildsystems/meson'

class Gcr_4 < Meson
  description 'GNOME crypto package'
  homepage 'https://www.gnome.org'
  version '4.4.1'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gcr.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c09be5fae4b801c89cc19d6115983bbc201c711fad4278d9c0ebf0f7b4099421',
     armv7l: 'c09be5fae4b801c89cc19d6115983bbc201c711fad4278d9c0ebf0f7b4099421',
     x86_64: '8dddabfed3ce7f2df7614ef47edb818d00ec7a1c8553a69bb5b0b4920a79726f'
  })

  depends_on 'cairo' => :build
  depends_on 'desktop_file_utilities' => :build
  depends_on 'gcc_lib' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnupg' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'graphite' => :build
  depends_on 'gtk3' => :build
  depends_on 'gtk4' => :executable
  depends_on 'hicolor_icon_theme' => :build
  depends_on 'libgcrypt' => :library
  depends_on 'libjpeg_turbo' => :build
  depends_on 'libsecret' => :executable
  depends_on 'libxslt' => :build
  depends_on 'p11kit' => :library
  depends_on 'pango' => :executable
  depends_on 'vala' => :build
  depends_on 'vulkan_headers' => :build

  gnome

  meson_options '-Dgtk_doc=false'
end
