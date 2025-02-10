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

  depends_on 'desktop_file_utils' # L
  depends_on 'gtk3' # L
  depends_on 'gtksourceview_4' # L
  depends_on 'py3_libxml2' # L
  depends_on 'py3_pycairo' # L
  depends_on 'py3_pygobject' # L
  depends_on 'python3' # L

  gnome
  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/meld"
    FileUtils.cp_r Dir['*'], "#{CREW_DEST_PREFIX}/share/meld"
    FileUtils.install 'data/meld.1', "#{CREW_DEST_MAN_PREFIX}/man1/meld.1", mode: 0o644
    FileUtils.ln_s "#{CREW_PREFIX}/share/meld/bin/meld", "#{CREW_DEST_PREFIX}/bin/meld"
  end
end
