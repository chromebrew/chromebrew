require 'buildsystems/python'

class Py3_devedeng < Python
  description 'DevedeNG is a program to create video DVDs and CDs (VCD, sVCD or CVD)'
  homepage 'https://www.rastersoft.com/programas/devede.html'
  version "4.18.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/rastersoft/devedeng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b476a4be173f380dec6a4b531778632dee701495693ab422afcd4fd94f772204',
     armv7l: 'b476a4be173f380dec6a4b531778632dee701495693ab422afcd4fd94f772204',
     x86_64: 'ead4f2c04701b4d29217719ac0602c5ac002adb98977ba350be9b15de61e36ef'
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
