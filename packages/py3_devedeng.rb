require 'buildsystems/python'

class Py3_devedeng < Python
  description 'DevedeNG is a program to create video DVDs and CDs (VCD, sVCD or CVD)'
  homepage 'https://www.rastersoft.com/programas/devede.html'
  version "4.21.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/rastersoft/devedeng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df580a3eec96fe5919cf4220c1407462efa14921ac587d39843cc0e1291b87ab',
     armv7l: 'df580a3eec96fe5919cf4220c1407462efa14921ac587d39843cc0e1291b87ab',
     x86_64: 'cfe5ea084596c70763ef59ced3c69570d0f3df93d3363c4e1d6d18462ef5a935'
  })

  depends_on 'python3' => :build
  depends_on 'py3_pycairo'
  depends_on 'py3_pygobject'
  depends_on 'gtk3'

  python_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/devede_ng.py", "#{CREW_DEST_PREFIX}/bin/devede"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/copy_files_verbose.py", "#{CREW_DEST_PREFIX}/bin/copy_files_verbose"
  end

  def self.postinstall
    ExitMessage.add "Type 'devede' to get started.".lightblue
  end
end
