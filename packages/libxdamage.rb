require 'buildsystems/meson'

class Libxdamage < Meson
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.1.7'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxdamage.git'
  git_hashtag "libXdamage-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '287f60fe7ff799b6af2eccc2a9d137f9920402e5359da4c5d2217d7e631011c6',
     armv7l: '287f60fe7ff799b6af2eccc2a9d137f9920402e5359da4c5d2217d7e631011c6',
     x86_64: 'c3dcb0193c433b72de5fea42a17bb6d1486a350f296e1f8a9cd7b75051a62748'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxfixes' => :build
end
