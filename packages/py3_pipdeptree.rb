require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11f4cd5a609fd7af324dc924b56d38c3d8da60b16c337d901e00017bdce11239',
     armv7l: '11f4cd5a609fd7af324dc924b56d38c3d8da60b16c337d901e00017bdce11239',
       i686: 'cf50e441fb3e33b588f3f9cb177df77f73d83177d76aa03cef2fa1ff9a527e28',
     x86_64: '8172063b3ea4c4ffd499d779252e6ffab4492ce978407ff4038afdf8871ab00c'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
