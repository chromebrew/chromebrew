require 'buildsystems/autotools'

class Libxrandr < Autotools
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.5.4'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxrandr.git'
  git_hashtag "libXrandr-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5214c31f48b76603894ed6db1189dfa8f9219dacccda3e467fc0aee7e1d104a9',
     armv7l: '5214c31f48b76603894ed6db1189dfa8f9219dacccda3e467fc0aee7e1d104a9',
     x86_64: '243cb4405c06bf87d121438237ed0fb915e6689ea3a3bb9652203cf5e9c59c2a'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_macros' => :build
  depends_on 'xorg_proto' => :build

  run_tests
end
