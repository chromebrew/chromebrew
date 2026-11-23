require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.16-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d1f73f5b032f9d96d09b2f14624fcb5d86e6fd92d6bdf379be301ed50e443da',
     armv7l: '9d1f73f5b032f9d96d09b2f14624fcb5d86e6fd92d6bdf379be301ed50e443da',
       i686: '0fb7cd6fbb2f9da43a30ef32007bd037746ed73a723143b4429cb29531f7e7ac',
     x86_64: 'da9b97e46857076dd51e9e6eff937b142c002188f9ca98d05b5462ed6d7a7cf0'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
