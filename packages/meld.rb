require 'package'

class Meld < Package
  description 'Meld is a visual diff and merge tool targeted at developers.'
  homepage 'https://meldmerge.org/'
  version "3.23.0-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/meld.git'
  git_hashtag '16224fb03d1652e2a5dc75e491719db539a106a0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd827ed76aceb0b6ce8b9966e045e28c8d331ec8b9e951a0df4267f46c34ed63',
     armv7l: 'fd827ed76aceb0b6ce8b9966e045e28c8d331ec8b9e951a0df4267f46c34ed63',
     x86_64: '440e9fa0612eacc6e9b9ba8fd61aecc80136d12fc48ec848552d281389b71ceb'
  })

  depends_on 'desktop_file_utils' # L
  depends_on 'gtk3' # L
  depends_on 'gtksourceview_4' # L
  depends_on 'py3_libxml2' # L
  depends_on 'py3_pycairo' # L
  depends_on 'py3_pygobject' # L
  depends_on 'python3' # L

  gnome

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/meld"
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/meld"
    FileUtils.install 'data/meld.1', "#{CREW_DEST_MAN_PREFIX}/man1/meld.1", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/meld/bin/meld", "#{CREW_DEST_PREFIX}/bin/meld"
  end
end
