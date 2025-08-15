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
    aarch64: '45f2927b7cdcb468a7b1bfa5a686033152c82102761556a21c54ad4cca1f7496',
     armv7l: '45f2927b7cdcb468a7b1bfa5a686033152c82102761556a21c54ad4cca1f7496',
     x86_64: 'ff7990530301e1a63dd79a7ef7d67c152acbce582204f77eb2c29bb0bc8b53c7'
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
