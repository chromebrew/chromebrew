require 'buildsystems/autotools'

class Libxt < Autotools
  description 'X.org X Toolkit Library'
  homepage 'https://www.x.org/wiki/'
  version '1.3.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxt.git'
  git_hashtag "libXt-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '770c9135580edda7155805de522b1b7d3ea50a2a738ff8dd9bb5cd9b4af79d64',
     armv7l: '770c9135580edda7155805de522b1b7d3ea50a2a738ff8dd9bb5cd9b4af79d64',
     x86_64: '0f7ea7ea8c176903751dc09c1f8bf40a41ee633c462e79c45a23f6b430b553c6'
  })

  depends_on 'libsm' => :build
  depends_on 'libx11' => :build
end
