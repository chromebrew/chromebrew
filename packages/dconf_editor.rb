require 'buildsystems/meson'

class Dconf_editor < Meson
  description 'A graphical viewer and editor of applications internal settings.'
  homepage 'https://wiki.gnome.org/Apps/DconfEditor'
  version '49.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/dconf-editor.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9fee0f070061643057225733b114e102c0fa55d544cafda6ebdb0d1c9a262cdb',
     armv7l: '9fee0f070061643057225733b114e102c0fa55d544cafda6ebdb0d1c9a262cdb',
     x86_64: '33b30f67aa1ccdd7926f3ff56894dbe8155c18b89fea27338093cdc68e266d26'
  })

  depends_on 'dconf' # R
  depends_on 'desktop_file_utils' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'libhandy' # R
  depends_on 'vala' => :build

  gnome
end
