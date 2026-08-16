require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '918339ce678dfe6702fce1b639d3459ee6e743a63fc524951d6694e5fcea324c',
     armv7l: '918339ce678dfe6702fce1b639d3459ee6e743a63fc524951d6694e5fcea324c',
       i686: '4232998f9a5633b67a8b5a3cc086d9b1e1b50565e413e4dd48601d5b56dc65e7',
     x86_64: '01d7cd32333cfd381718bc2ca2ec3249805365eee9d017a94e852b324c76c2db'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
