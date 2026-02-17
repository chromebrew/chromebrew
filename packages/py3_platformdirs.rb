require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.9.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed38c8110ec1588566d93a910c4a243dd0755cd96176bbec654741140efe7b4e',
     armv7l: 'ed38c8110ec1588566d93a910c4a243dd0755cd96176bbec654741140efe7b4e',
       i686: 'ba261f7e2b0d0c609fb8029be26eae034a2040346109af1ad026bc9f458d9b79',
     x86_64: '938c8917feb37c7a12175248a722af59421d8ac14e0b0486a314471463ada578'
  })

  depends_on 'python3' => :build

  no_source_build
end
