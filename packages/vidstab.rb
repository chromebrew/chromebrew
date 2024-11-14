require 'buildsystems/cmake'

class Vidstab < CMake
  description 'Transcode video stabilization plugin.'
  homepage 'http://public.hronopik.de/vid.stab/'
  version '1.1.1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/georgmartius/vid.stab.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fabc6a0fb8cc0570cd9c9ab031c5bdc331007ea5f3b2edaa1efb56818915ae7e',
     armv7l: 'fabc6a0fb8cc0570cd9c9ab031c5bdc331007ea5f3b2edaa1efb56818915ae7e',
       i686: '8feab77e6b415747500ec4d398cfefdc8f94a13244b61beea7eceb1c4e859835',
     x86_64: 'e55882a58cb795e010a3fcdbd5a43d636f8446389874c77cd231cbea71d6d1cc'
  })
end
