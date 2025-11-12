require 'buildsystems/meson'

class Gnome_mines < Meson
  description 'GNOME Mines (formerly known as Gnomine) is minesweeper clone for GNOME'
  homepage 'https://wiki.gnome.org/Apps/Mines'
  version '49.0.1'
  license 'GPL-3+ and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-mines.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd73ee740fc15ad7336544d9ec41255f7838377a28927de5bd06cb3c7eb5610f5',
     armv7l: 'd73ee740fc15ad7336544d9ec41255f7838377a28927de5bd06cb3c7eb5610f5',
     x86_64: 'b350dd6d4692bf330f78806c7b00210e15d45430994322bf3bc83717366f2699'
  })

  depends_on 'clutter_gtk' => :build
  depends_on 'desktop_file_utils' => :build
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gsound' => :build
  depends_on 'gtk4' # R
  depends_on 'libadwaita' # R
  depends_on 'libgee' # R
  depends_on 'librsvg' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'vala' => :build
  depends_on 'wayland' => :build

  gnome
  no_lto
end
