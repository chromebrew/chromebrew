require 'buildsystems/meson'

class Libgedit_amtk < Meson
  description 'Actions, Menus and Toolbars Kit for GTK+ applications'
  homepage 'https://gedit-technology.github.io'
  version '5.11.0'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/World/gedit/libgedit-amtk.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ca47881449394d6f7fd4b708c7e644498635412cd8c3396cf715e75e942b90a',
     armv7l: '1ca47881449394d6f7fd4b708c7e644498635412cd8c3396cf715e75e942b90a',
     x86_64: '44df73aad8da2fa307f317fdf9c8f57e9e031698781f21dfcfa62865f732d2c2'
  })

  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' => :library
  depends_on 'llvm_lib' => :build

  meson_options '-Dgtk_doc=false'
end
