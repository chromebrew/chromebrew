require 'buildsystems/python'

class Gyp_next < Python
  description 'GYP is a fork of the GYP build system for use in the Node.js projects.'
  homepage 'https://github.com/nodejs/gyp-next/'
  version '0.16.1'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/nodejs/gyp-next.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90a81ca2b1bf7d1dca2e43bad60fca6c54945e90e2a20c51901083eb9fff979d',
     armv7l: '90a81ca2b1bf7d1dca2e43bad60fca6c54945e90e2a20c51901083eb9fff979d',
       i686: 'a4c77a68276d9608647bf4b990716352f5c37ef17c58c06ab15ede72c01c0307',
     x86_64: '005ded43a97cd2818685ac46d0fa70b5d4bab2bbeb83e663540396378ecab0f6'
  })

  depends_on 'python3' => :build
end
