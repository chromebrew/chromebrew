require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.34-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6605117900ac5585ffc4064b1d6dde1d12ad0d4d5e415cc90ab0fa4304416da8',
     armv7l: '6605117900ac5585ffc4064b1d6dde1d12ad0d4d5e415cc90ab0fa4304416da8',
       i686: '9283312e43ae1c11c999e192460ab1b8c6c22fdc46633cd49c1e2f169af10d41',
     x86_64: '2915dcf99e2a85a5fecc63c7cbd1dccd577d62e3d036f33d4cabf4073a78856c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
