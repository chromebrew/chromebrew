require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version "1.10.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f40289c4dea96b00d8a5d98e5bf76e0aeb6583bc77a20e1ee8c1e072a73b7cb',
     armv7l: '5f40289c4dea96b00d8a5d98e5bf76e0aeb6583bc77a20e1ee8c1e072a73b7cb',
       i686: 'f82f0da32b291af8fab801a1135e3865b3edccb997770fd4086838889bb7e657',
     x86_64: '952b75c25e84015b64fb0c68bc3d0af5a863b61e9693e7f7a11908bc6cfeeb37'
  })

  depends_on 'rust'
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3'

  no_source_build
end
