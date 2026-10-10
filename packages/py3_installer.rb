require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "1.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71375eb41aafef99b0f16c12ebd45cbfb0381a0627834ac1f0f051d2e87f5a2c',
     armv7l: '71375eb41aafef99b0f16c12ebd45cbfb0381a0627834ac1f0f051d2e87f5a2c',
       i686: 'a7b20be2080e5cff5132d1c0869a709158e36ae60d74adf04dcb5c1ee16bac3d',
     x86_64: '25b36bef89a9f9e16b3506333182e7693f648408047e619e4cc4ef734beb5653'
  })

  depends_on 'python3' => :logical

  no_source_build
end
