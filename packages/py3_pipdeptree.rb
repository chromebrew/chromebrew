require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "2.35.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af1b857c8b5eecd87c94184c2f16b379236f420b999d76fa793a1e0838fbea3a',
     armv7l: 'af1b857c8b5eecd87c94184c2f16b379236f420b999d76fa793a1e0838fbea3a',
       i686: 'e9e79839f2d53a0b2c1ceb63cc73a8efcd933337c2f8ff8591431fd069ea95a2',
     x86_64: '2c3eda4e3090d455b1a2cee785ffd7498497cb3c6c73e56cb37c26720e93eee2'
  })

  depends_on 'python3' => :logical

  no_source_build
end
