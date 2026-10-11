require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8649f7ac5b5ce80ef1ea76629d7cafbd5031c0450f835705a871b5d62b6e5ccb',
     armv7l: '8649f7ac5b5ce80ef1ea76629d7cafbd5031c0450f835705a871b5d62b6e5ccb',
       i686: 'ea30e66e8a236e0840525ba0813f8c50911284f5638ea492dcedb1c5fe056d33',
     x86_64: '007fd48e45ca67c66b8e4f0a9c27397b9107e465f74ee38830835066d7feeff7'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
