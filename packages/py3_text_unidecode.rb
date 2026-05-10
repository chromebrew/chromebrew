require 'buildsystems/pip'

class Py3_text_unidecode < Pip
  description 'Text-unicode is the most basic Text::Unidecode port.'
  homepage 'https://github.com/kmike/text-unidecode/'
  version "1.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '965f2efe1a809fbf3216b47b4feef6732b78305f84f2819ee495281599760605',
     armv7l: '965f2efe1a809fbf3216b47b4feef6732b78305f84f2819ee495281599760605',
       i686: 'e4ca8970ade7d7707c7c6d6692cff8802716cbba03d44355a7a02011bf1d5d02',
     x86_64: '50e8fc5d0391bb71b1ec60b949a4f92611fae4d731f0e6c97ee308fbbbccaf72'
  })

  depends_on 'python3' => :logical

  no_source_build
end
