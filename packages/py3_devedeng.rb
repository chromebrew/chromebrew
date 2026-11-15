require 'buildsystems/python'

class Py3_devedeng < Python
  description 'DevedeNG is a program to create video DVDs and CDs (VCD, sVCD or CVD)'
  homepage 'https://www.rastersoft.com/programas/devede.html'
  version "4.22.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/rastersoft/devedeng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01a918970a55212c7dd242b5b4cc23b82742cfb882f1a125910d31b4aea75ac7',
     armv7l: '01a918970a55212c7dd242b5b4cc23b82742cfb882f1a125910d31b4aea75ac7',
     x86_64: 'ef883ac803e53e4543bc2ff6e783ca1bf68cbdb76cffdf82371059bcb3e80a04'
  })

  depends_on 'gtk3'
  depends_on 'py3_pycairo'
  depends_on 'py3_pygobject'
  depends_on 'python3' => :logical

  python_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/devede_ng", "#{CREW_DEST_PREFIX}/bin/devede"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/copy_files_verbose.py", "#{CREW_DEST_PREFIX}/bin/copy_files_verbose"
  end

  def self.postinstall
    ExitMessage.add "\nType 'devede' to get started.\n"
  end
end
