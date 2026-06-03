require 'buildsystems/meson'

class Meld < Meson
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  version "3.23.1-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/meld.git'
  git_hashtag version.gsub("-#{CREW_PY_VER}", '')
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '967dbdc9fb8254e73b47d8d426303c8cd578a9b0ba9e72ea19c217eb56b9d3b7',
     armv7l: '967dbdc9fb8254e73b47d8d426303c8cd578a9b0ba9e72ea19c217eb56b9d3b7',
     x86_64: 'cb3c04c221d83be9ecf6d8aa3bb8b427454cee1edc17be256a59c0d3920aed95'
  })

  depends_on 'desktop_file_utils' => :logical
  depends_on 'gtk3' => :build
  depends_on 'gtksourceview_4' => :logical
  depends_on 'xvfb' => :build
  depends_on 'py3_itstool' => :build
  depends_on 'py3_libxml2' => :logical
  depends_on 'py3cairo' => :logical
  depends_on 'py3_pygobject' => :logical
  depends_on 'python3' => :logical

  gnome

  def self.patch
    system "sed -i 's,/usr,#{CREW_PREFIX},g' bin/meld"
  end
end
