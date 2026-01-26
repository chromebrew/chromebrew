require 'buildsystems/meson'

class Libxkbfile < Meson
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.2.0'
  license 'MIT and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxkbfile.git'
  git_hashtag "libxkbfile-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e80b733419560e44aca358fd431d4e82d5af8cc5738e0883312272f4256090f',
     armv7l: '3e80b733419560e44aca358fd431d4e82d5af8cc5738e0883312272f4256090f',
     x86_64: '72a03aa9268078f5b40fcc0c8ca7f669f5f5ffce14a48eb653c2615c9f29c87e'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
end
