require 'buildsystems/meson'

class Foliate < Meson
  description 'A simple and modern GTK eBook reader'
  homepage 'https://johnfactotum.github.io/foliate/'
  version '3.1.1'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/johnfactotum/foliate.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0bc98dec8ec482f60e05a8758bb98c0a581ed9d1bb093755d7e2075cffec1c6',
     armv7l: 'f0bc98dec8ec482f60e05a8758bb98c0a581ed9d1bb093755d7e2075cffec1c6',
     x86_64: '24c4a76b361c91e81e8a584d8bb34bc4a417bb07408d1f7ff46af0fd22aad664'
  })

  depends_on 'desktop_file_utils'
  depends_on 'gdk_base'
  depends_on 'gettext' => :build
  depends_on 'gjs'
  depends_on 'gtk4'
  depends_on 'iso_codes'
  depends_on 'libadwaita'
  depends_on 'sommelier'
  depends_on 'webkitgtk_6'

  gnome
end
