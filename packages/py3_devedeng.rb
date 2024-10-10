require 'buildsystems/python'

class Py3_devedeng < Python
  description 'DevedeNG is a program to create video DVDs and CDs (VCD, sVCD or CVD)'
  homepage 'https://www.rastersoft.com/programas/devede.html'
  version "4.18.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.com/rastersoft/devedeng.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '955b01867d1571a9bbff2f197c50de5aaa475e610a403066a4124568eb2d41c4',
     armv7l: '955b01867d1571a9bbff2f197c50de5aaa475e610a403066a4124568eb2d41c4',
     x86_64: 'f5b0e921aca08f0c46b02ff95e5fca125c015be55025148ca5fddc692b7ed6cb'
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
