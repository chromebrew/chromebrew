require 'buildsystems/pip'

class Py3_mutagen < Pip
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  version "1.48.1-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '45b5a3fd6d677e1a066091b9ed1b10a467567345df585704269363068b37cda3',
     armv7l: '45b5a3fd6d677e1a066091b9ed1b10a467567345df585704269363068b37cda3',
       i686: '6d178bb9343a8628eacc6980751ae49b344c7e1b1abeb20cc609ee873052e4a5',
     x86_64: '97c4ef8f6de00130c36e75832d412126e0f463d1dd871dadaba78f57d30da791'
  })

  depends_on 'python3' => :logical

  no_source_build
end
