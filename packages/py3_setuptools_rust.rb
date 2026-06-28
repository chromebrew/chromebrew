require 'buildsystems/pip'

class Py3_setuptools_rust < Pip
  description 'Setuptools-rust provides rust support for setuptools.'
  homepage 'https://github.com/PyO3/setuptools-rust'
  version "1.13.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdb41ad3b1b71be323030d629a39a9ab4a69db5fd701968be916ebbb25464c3b',
     armv7l: 'cdb41ad3b1b71be323030d629a39a9ab4a69db5fd701968be916ebbb25464c3b',
       i686: 'f8a9171d1db149c836bbe8253bb1c5972db056ff276b747381a6b22b26794986',
     x86_64: '2fe907daf168b4b4414e072d881ac54a4b1fef78589c83060363a7348384b8cb'
  })

  depends_on 'py3_setuptools_scm' => :build
  depends_on 'py3_typing_extensions' => :build
  depends_on 'python3' => :logical
  depends_on 'rust'

  no_source_build
end
