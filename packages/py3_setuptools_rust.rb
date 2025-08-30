require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version "1.12.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bf252fadaffb25db070b350e27e407526f61ed7cf1aa3595628071b5d8a6774',
     armv7l: '7bf252fadaffb25db070b350e27e407526f61ed7cf1aa3595628071b5d8a6774',
       i686: '4320f8666cebbc8e246db45938ae13e7b941a056da78fd5d45223e6b0e48457f',
     x86_64: 'b24840af22ac51d122128d22fd00eaa2b3dc15109cabe07fe1262ae54da58a60'
  })

  depends_on 'rust'
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3'

  no_source_build
end
