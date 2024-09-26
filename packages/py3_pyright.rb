require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.382-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c6e630b87fbb2b87a17e029696cd54796d303e1bf5124141bdff7f08c61b3962',
     armv7l: 'c6e630b87fbb2b87a17e029696cd54796d303e1bf5124141bdff7f08c61b3962',
       i686: '44d26d947900dc8c3653d455febe8664aebfdcc4cd50dd6df4f4a3381bc30167',
     x86_64: 'c1afaa10b254ea11a745dd4d07cbd706ad71d5b734cd498f53409daf46b1c032'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
