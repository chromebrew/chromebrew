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
    aarch64: '3a6e041069dede588b118d92a099ba0ce92aa70dfd5905c22e795f15e38aae9d',
     armv7l: '3a6e041069dede588b118d92a099ba0ce92aa70dfd5905c22e795f15e38aae9d',
     x86_64: 'fd77cf75388c77f23704bdc96bcfaf2647fc22f5623c3f777769bc5985125590'
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
