require 'buildsystems/cmake'

class Nanosvg < CMake
  description 'Simple stupid SVG parser'
  homepage 'https://github.com/memononen/nanosvg'
  version '5cefd98'
  license 'Zlib'
  compatibility 'all'
  source_url 'https://github.com/memononen/nanosvg.git'
  git_hashtag '5cefd9847949af6df13f65027fd43af5a7513633'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '966062905fe09ac6386b2d9a0864f2fb288dddd139072ad659ea69e61dc7ef74',
     armv7l: '966062905fe09ac6386b2d9a0864f2fb288dddd139072ad659ea69e61dc7ef74',
       i686: 'fab71dc07e59e19c655aa2e9083f92cd7e70847b9b956342f0a8834827e65a74',
     x86_64: '0c5f572e5563a433f35a608eecff82a02bb6f08eb983e21852174dcd5d1d6a0e'
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
