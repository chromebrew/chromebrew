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
    aarch64: 'fd827ed76aceb0b6ce8b9966e045e28c8d331ec8b9e951a0df4267f46c34ed63',
     armv7l: 'fd827ed76aceb0b6ce8b9966e045e28c8d331ec8b9e951a0df4267f46c34ed63',
     x86_64: '440e9fa0612eacc6e9b9ba8fd61aecc80136d12fc48ec848552d281389b71ceb'
  })

  depends_on 'desktop_file_utils' => :logical
  depends_on 'gtk3' => :build
  depends_on 'gtksourceview_4' => :logical
  depends_on 'py3_libxml2' => :logical
  depends_on 'py3_pycairo' => :logical
  depends_on 'py3_pygobject' => :logical
  depends_on 'python3' => :logical

  gnome
end
