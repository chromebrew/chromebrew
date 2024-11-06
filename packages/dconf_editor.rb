require 'buildsystems/meson'

class Dconf_editor < Meson
  description 'A graphical viewer and editor of applications internal settings.'
  homepage 'https://wiki.gnome.org/Apps/DconfEditor'
  version '45.0.1'
  license 'GPL-3+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/dconf-editor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c86a83d7f2c3466cc6004be1c5476610a039a60ec9cd3067b33a47ee051ad0a7',
     armv7l: 'c86a83d7f2c3466cc6004be1c5476610a039a60ec9cd3067b33a47ee051ad0a7',
     x86_64: '85203822f7be8a89fedeb479e2cdd9617910032474dc4324a49475ca63d9cc87'
  })

  depends_on 'dconf' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gtk3' => :build
  depends_on 'libhandy' # R
  depends_on 'vala' => :build
  depends_on 'dconf' # R
  depends_on 'gtk3' # R

  gnome
end
