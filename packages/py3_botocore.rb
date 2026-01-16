require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.29-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '205995b9cfce26d6245cdb3d28d6cf6afd43bc52affdb1b6787ded37e0502e69',
     armv7l: '205995b9cfce26d6245cdb3d28d6cf6afd43bc52affdb1b6787ded37e0502e69',
       i686: '8e03888e8b281991ff9c0c84ba90dc063cf50d80b3c38aab9959543aaff66211',
     x86_64: '438f3894455df0a55ad5857b1d436489bf344b240295ca3e0c0bcd04b791cd4a'
  })

  depends_on 'python3' => :build

  no_source_build
end
