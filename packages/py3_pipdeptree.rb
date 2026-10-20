require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5f4af53f59673247766cd4054cc74bdd4638ddfc44ae078713de6634c6cfd44',
     armv7l: 'e5f4af53f59673247766cd4054cc74bdd4638ddfc44ae078713de6634c6cfd44',
       i686: '3e94e2e091e4e636e261032e11d5c47d517c0995976c9106a59de59261604646',
     x86_64: 'd923ee83839455c3f1155a633348a1bc341bae6b4a57e7ef11ec32d954430966'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
