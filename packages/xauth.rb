require 'buildsystems/autotools'

class Xauth < Autotools
  description 'X authority file utility'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xauth.1.html'
  version '1.1.5'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xauth.git'
  git_hashtag "xauth-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c775827ef0612000b0f1afb14e9477aac86c0776678a9670d534594ca4b7e963',
     armv7l: 'c775827ef0612000b0f1afb14e9477aac86c0776678a9670d534594ca4b7e963',
     x86_64: '71101012a3748d899bd245241690bff3ca67fa32a6a37907f9cae8b4a6e655e8'
  })

  depends_on 'glibc' => :library
  depends_on 'libx11' => :library
  depends_on 'libxau' => :library
  depends_on 'libxext' => :library
  depends_on 'libxmu' => :library

  autotools_configure_options '--enable-ipv6 \
           --enable-tcp-transport \
           --enable-unix-transport \
           --enable-local-transport'
end
