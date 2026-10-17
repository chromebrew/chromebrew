require 'buildsystems/autotools'

class Libx11 < Autotools
  description 'C interface to the X window system'
  homepage 'https://x.org/wiki/'
  version '1.8.14'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8410f84371839eaacfeef55539ca92de260c31c6ad570c757a4bfb787dccd4ac',
     armv7l: '8410f84371839eaacfeef55539ca92de260c31c6ad570c757a4bfb787dccd4ac',
       i686: 'e9b2caeb62fa45717af5f66b8b3f3717734a7179f5e30327906935e135ae3f45',
     x86_64: 'ee065b84f671ec547976356f6e20671e91844e67ae21b8ab012869a90049f112'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libbsd' => :library
  depends_on 'libxau' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxdmcp' => :library
  depends_on 'libxtrans' => :build
  depends_on 'llvm_lib' => :build
  depends_on 'xorg_proto' => :build
end
