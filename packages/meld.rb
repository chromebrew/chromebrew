require 'buildsystems/meson'

class Meld < Meson
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  version "3.24.1-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/meld.git'
  git_hashtag version.split('-')[0]
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00b81ca77c6db07d3d6090532469421508bf34b464368fbf0e91f85068bfed4c',
     armv7l: '00b81ca77c6db07d3d6090532469421508bf34b464368fbf0e91f85068bfed4c',
     x86_64: '7987b9bc24938a2b55492bd7355d98d166f39fad0b2d2ab96d95261b19980538'
  })

  depends_on 'appstream' => :executable
  depends_on 'desktop_file_utils' => :logical
  depends_on 'gtk4' => :build
  depends_on 'gtksourceview_4' => :logical
  depends_on 'py3_itstool' => :build
  depends_on 'py3_libxml2' => :logical
  depends_on 'py3_pygobject' => :logical
  depends_on 'py3cairo' => :logical
  depends_on 'python3' => :logical
  depends_on 'xvfb' => :build

  gnome

  def self.patch
    system "sed -i 's,/usr,#{CREW_PREFIX},g' bin/meld"
  end
end
