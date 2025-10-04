require 'buildsystems/meson'

class Libxfixes < Meson
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '6.0.2'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxfixes.git'
  git_hashtag "libXfixes-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '382ea27297662360fef8172baaba5399230941b1c3f1657782055c95310519cb',
     armv7l: '382ea27297662360fef8172baaba5399230941b1c3f1657782055c95310519cb',
     x86_64: 'bc9b2c8f73ee928f68011672150a3e432692f294eeb4e9bf1dea5903bd428978'
  })

  depends_on 'libx11' # R
  depends_on 'glibc' # R
end
