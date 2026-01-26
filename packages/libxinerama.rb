require 'buildsystems/meson'

class Libxinerama < Meson
  description 'Xorg library, Xinerama is an X11 extension which provides support for extending a desktop across multiple displays.'
  homepage 'https://www.x.org/wiki/'
  compatibility 'aarch64 armv7l x86_64'
  license 'MIT'
  version '1.1.6'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxinerama.git'
  git_hashtag "libXinerama-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7e4f8a670a81d21e260cae9fa763b9827dfbea0117ed9f2832bc5e9aeabe6308',
     armv7l: '7e4f8a670a81d21e260cae9fa763b9827dfbea0117ed9f2832bc5e9aeabe6308',
     x86_64: '16efedc266f3e9f78fbbaa0d88f1c8c0883dd86ead34c64dd3ce8c3f596138ba'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' => :build
  depends_on 'libxext' # R
end
