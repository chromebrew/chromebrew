require 'buildsystems/meson'

class Xwininfo < Meson
  description 'Utility to print information about windows on an X server.'
  homepage 'https://gitlab.freedesktop.org/xorg/app/xwininfo'
  version '1.1.7'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xwininfo.git'
  git_hashtag "xwininfo-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb03cdd01e28ace075f44b720471bbe61ce3a08b5e6ce47b460c550f067472b4',
     armv7l: 'cb03cdd01e28ace075f44b720471bbe61ce3a08b5e6ce47b460c550f067472b4',
     x86_64: 'f3db7149ab5b30c79bb4a6fefc839401426820ccef59215484bf6dca8bdd867b'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxcb' => :executable
end
