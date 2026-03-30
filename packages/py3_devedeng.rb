require 'buildsystems/python'

class Py3_devedeng < Python
  description 'DevedeNG is a program to create video DVDs and CDs (VCD, sVCD or CVD)'
  homepage 'https://www.rastersoft.com/programas/devede.html'
  version "4.21.3.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/rastersoft/devedeng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4bab68e6d3c288fb46b09161db8377c477ba72fb36cf83d3eb4c15fd1b97742',
     armv7l: 'd4bab68e6d3c288fb46b09161db8377c477ba72fb36cf83d3eb4c15fd1b97742',
     x86_64: 'e76936fb0076d3e5513c254b76338cbb3fce94679becd85632a0a7668729ebfb'
  })

  depends_on 'gtk3'
  depends_on 'py3_pycairo'
  depends_on 'py3_pygobject'
  depends_on 'python3' => :logical

  python_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/devede_ng.py", "#{CREW_DEST_PREFIX}/bin/devede"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/copy_files_verbose.py", "#{CREW_DEST_PREFIX}/bin/copy_files_verbose"
  end

  def self.postinstall
    ExitMessage.add "Type 'devede' to get started.".lightblue
  end
end
