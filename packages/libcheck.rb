require 'buildsystems/autotools'

class Libcheck < Autotools
  description 'A unit testing framework for C'
  homepage 'https://libcheck.github.io/check/'
  version '0.15.2'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/libcheck/check.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71a129c63ce759b17a6a9ce7c30eecadb633a24242170d9a6646a9c45c64eac4',
     armv7l: '71a129c63ce759b17a6a9ce7c30eecadb633a24242170d9a6646a9c45c64eac4',
       i686: '48d3bea93e956e8089ba520a48761d40148be6009aa4d93f801e4f6627e75755',
     x86_64: '9522b0a5173a563716f2f435d1ef26e61f39eebea16c6ece97aea037a5db9ba3'
  })
end
