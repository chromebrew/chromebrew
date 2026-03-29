require 'buildsystems/meson'

class Libgedit_amtk < Meson
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://gedit-technology.github.io'
  version '5.10.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-amtk.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f634f3ed5209b7da42361aa19aee75f12dd8dbd8b601584f01350393d2537d81',
     armv7l: 'f634f3ed5209b7da42361aa19aee75f12dd8dbd8b601584f01350393d2537d81',
     x86_64: '5921da4b41961fd1220b42d58695a48f5f276f24a7ee89caf6667ee8b343a5c1'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :library
  depends_on 'llvm_lib' => :build

  meson_options '-Dgtk_doc=false'
end
