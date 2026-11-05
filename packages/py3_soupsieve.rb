require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "4.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ea587527283e98c81d7c8bc1f1313051367690fef118628d365a749fc2d9c29',
     armv7l: '0ea587527283e98c81d7c8bc1f1313051367690fef118628d365a749fc2d9c29',
       i686: '02fd46b96ed100d13778a77ad60dd4a3ed4179d42c3de1c3c17f405eb79a5568',
     x86_64: '306f68c06e638d0e72fddc770d3c0301b8feda4fce4b1a216a68ea808569cc06'
  })

  depends_on 'python3' => :logical

  no_source_build
end
