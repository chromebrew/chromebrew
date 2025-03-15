require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version "1.11.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f40289c4dea96b00d8a5d98e5bf76e0aeb6583bc77a20e1ee8c1e072a73b7cb',
     armv7l: '5f40289c4dea96b00d8a5d98e5bf76e0aeb6583bc77a20e1ee8c1e072a73b7cb',
       i686: 'a5a056be26007b3b6b7f4cf0fbf38f4f85f8371971c3e2d741c8e71a26891e21',
     x86_64: 'c3d6c55421000edce97631631b7d47ec9fcc28f08f602ad4bba24d2d2926e670'
  })

  depends_on 'rust'
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3'

  no_source_build
end
