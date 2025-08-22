require 'buildsystems/autotools'

class Xauth < Autotools
  description 'X authority file utility'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xauth.1.html'
  version '1.1.4'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xauth.git'
  git_hashtag "xauth-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '562e0d8445ab4be079b36ea1182a8f02159f9b9e2fea68ca2408021fb7d84323',
     armv7l: '562e0d8445ab4be079b36ea1182a8f02159f9b9e2fea68ca2408021fb7d84323',
     x86_64: '4891ea00bf649cd7d9e85f63f8270ae81788f32691720f6a69edb8c3ec61a913'
  })

  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxext' # R
  depends_on 'libxmu' # R
  depends_on 'glibc' # R

  autotools_configure_options '--enable-ipv6 \
           --enable-tcp-transport \
           --enable-unix-transport \
           --enable-local-transport'
end
