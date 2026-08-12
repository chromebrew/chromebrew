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
    aarch64: 'da1ea8dae386a0df18822ac4d74990788c8e40b3f82f36804644bb86d06a69b2',
     armv7l: 'da1ea8dae386a0df18822ac4d74990788c8e40b3f82f36804644bb86d06a69b2',
     x86_64: '502b916de666e1930962a7aea09c7e42f33c14655ad51e6d980c4a8ac598bfa9'
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
