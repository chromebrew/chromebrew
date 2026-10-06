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
    aarch64: 'e4c396bbe369900bc8bb995810d0a8dba2d25571d531bd8118b35aeb4278c2f2',
     armv7l: 'e4c396bbe369900bc8bb995810d0a8dba2d25571d531bd8118b35aeb4278c2f2',
     x86_64: '955fac35a5931784d613fdbb1747534dad7470a18262ebb45aa2dfdf04fd7ac7'
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
