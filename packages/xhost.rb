require 'buildsystems/autotools'

class Xhost < Autotools
  description 'Server access control program for X'
  homepage 'https://github.com/freedesktop/xorg-xhost'
  version '1.0.10'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xhost.git'
  git_hashtag "xhost-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
     armv7l: '314e4cf5b09e6e4517639c6904efd5e7cb1336536524f102c210e9e5c4388b5b',
     x86_64: '8e108d51711153c01c45343af91d6b1c7bd493e4da823ebe85209eb5278ee25a'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxmu' # R

  autotools_configure_options '--enable-ipv6 \
           --enable-tcp-transport \
           --enable-unix-transport \
           --enable-local-transport'
end
