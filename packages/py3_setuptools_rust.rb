require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version "1.11.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4072d4655276ab7188e2197dede39c88b5c329a41f90a2add30b234f125375bd',
     armv7l: '4072d4655276ab7188e2197dede39c88b5c329a41f90a2add30b234f125375bd',
       i686: '1a79527127c6331c5cc571da59c13202ce64bb386aa849db460e4a8914e24b85',
     x86_64: 'c3d6c55421000edce97631631b7d47ec9fcc28f08f602ad4bba24d2d2926e670'
  })

  depends_on 'rust'
  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3'

  no_source_build
end
