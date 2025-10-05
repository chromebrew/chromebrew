require 'package'

class Libxt < Package
  description 'X.org X Toolkit Library'
  homepage 'https://www.x.org/wiki/'
  version '1.3.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxt.git'
  git_hashtag "libXt-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36cf66c85c25f7b86690b34119b54b5cafb8cb9e9ce0999f191992a9f97a3f0e',
     armv7l: '36cf66c85c25f7b86690b34119b54b5cafb8cb9e9ce0999f191992a9f97a3f0e',
     x86_64: 'ceddbf9b53e8d880667c52b57b2093a45bdc178b92e37264b8bf37637319965c'
  })

  depends_on 'libsm' => :build
  depends_on 'libx11' => :build
end
