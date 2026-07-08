require 'buildsystems/cmake'

class Nanosvg < CMake
  description 'Simple stupid SVG parser'
  homepage 'https://github.com/memononen/nanosvg'
  version '48120e9'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/memononen/nanosvg.git'
  git_hashtag '48120e91e64b2f409ed600cdfd6d790a49ba11ab'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '188b835c56ac89d65817f3751d484c4271d19cce1524acfa2e40e029fa7c86dc',
     armv7l: '188b835c56ac89d65817f3751d484c4271d19cce1524acfa2e40e029fa7c86dc',
       i686: '3d6b543a267516d990a3b4ea462fb055da5c5fbeae3b571ab208ef453e0fb5d7',
     x86_64: '18e44860c8eadb74726b49f01a6c2b4a63c06f010859502b12f5758ad4b7eb8f'
  })

  def self.patch
    patches = [
      [
        # Fix cmake library installation.
        'https://patch-diff.githubusercontent.com/raw/memononen/nanosvg/pull/245.diff',
        '97efc38f2f655a1056da15c57587e2efc1226913a59e4730452dccf3d1a204f2'
      ],
      [
        # Add soversion number 0.
        'https://patch-diff.githubusercontent.com/raw/memononen/nanosvg/pull/246.diff',
        '22b237158e0ff0976aaf946cc66656d4c2e15a7fd8c01d4f97ef7b2c593ba5d7'
      ]
    ]
    ConvenienceFunctions.patch(patches)
  end
end
