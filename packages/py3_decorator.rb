require 'buildsystems/pip'

class Py3_decorator < Pip
  description 'define signature-preserving function decorators and decorator factories'
  homepage 'https://github.com/micheles/decorator/'
  version "5.2.1-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '76a08379fd29e63919bfdb47d7feea7051be5f230346e4e2e607f1f537896f7b',
     armv7l: '76a08379fd29e63919bfdb47d7feea7051be5f230346e4e2e607f1f537896f7b',
       i686: '5b6f323f54d08e000c57d1edfb541eeda201ffce51d547bf29616d3a6c5622f6',
     x86_64: '85b8075edafb741fc60bebf00c6334f1f4050f5cca2549903dfdde2ca4f5f8ba'
  })

  depends_on 'python3' => :build

  no_source_build
end
