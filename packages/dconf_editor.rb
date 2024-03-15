require 'buildsystems/meson'

class Dconf_editor < Meson
  description 'A graphical viewer and editor of applications internal settings.'
  homepage 'https://wiki.gnome.org/Apps/DconfEditor'
  version '45.0.1'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/dconf-editor.git"
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50ff5adc092e785f07f089818a7c0fd1fd6229ea1b0e07e978f45b2f92ecd99c',
     armv7l: '50ff5adc092e785f07f089818a7c0fd1fd6229ea1b0e07e978f45b2f92ecd99c',
     x86_64: 'f4b41bd1febd465c57b534a8d04346e83a61b52904f0c9f8fbe7b88b28ace047'
  })

  depends_on 'dconf' => :build
  depends_on 'gtk3' => :build
  depends_on 'vala' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libhandy' # R

  gnome
end
