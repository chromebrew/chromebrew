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
    aarch64: '921e89d68953baaf141bf20f1d388dfbb0639df59fea2e38930445b6e25dc24c',
     armv7l: '921e89d68953baaf141bf20f1d388dfbb0639df59fea2e38930445b6e25dc24c',
     x86_64: '86a24d8a4801d3bcfaecffe66256e9fa43052b8c965b585e6b54e5bbe7a6a64a'
  })

  depends_on 'appstream' => :executable
  depends_on 'desktop_file_utils' => :logical
  depends_on 'gtk4' => :build
  depends_on 'gtksourceview_4' => :logical
  depends_on 'py3_itstool' => :build
  depends_on 'py3_libxml2' => :logical
  depends_on 'py3_pygobject' => :logical
  depends_on 'py3cairo' => :logical
  depends_on 'pygtk' => :logical
  depends_on 'python3' => :logical
  depends_on 'xvfb' => :build

  gnome

  def self.patch
    system "sed -i 's,/usr,#{CREW_PREFIX},g' bin/meld"
  end
end
