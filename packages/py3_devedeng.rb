require 'buildsystems/python'

class Py3_devedeng < Python
  description 'DevedeNG is a program to create video DVDs and CDs (VCD, sVCD or CVD)'
  homepage 'https://www.rastersoft.com/programas/devede.html'
  @_ver = '4.18.0'
  version "#{@_ver}-py3.12"
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.com/rastersoft/devedeng.git'
  git_hashtag @_ver

  depends_on 'python3' => :build
  depends_on 'py3_pycairo'
  depends_on 'pygobject'
  depends_on 'gtk3'

  no_compile_needed

  python_install_extras <<~EOF
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/devede_ng.py", "#{CREW_DEST_PREFIX}/bin/devede"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/copy_files_verbose.py", "#{CREW_DEST_PREFIX}/bin/copy_files_verbose"
  EOF

  def self.postinstall
    ExitMessage.add "Type 'devede' to get started.".lightblue
  end
end
