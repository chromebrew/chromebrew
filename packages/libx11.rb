require 'buildsystems/autotools'

class Libx11 < Autotools
  description 'C interface to the X window system'
  homepage 'https://x.org/wiki/'
  version '1.8.13'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0009ee8b23ac878a9942b615ae1b8b5bcca181ba5b269687aeb31ec702af4d3',
     armv7l: 'b0009ee8b23ac878a9942b615ae1b8b5bcca181ba5b269687aeb31ec702af4d3',
       i686: 'ee917f76388fa5410afa228aa172e825c92fe23f7839531db7972fe223e6ae8f',
     x86_64: 'a49dc007edb02262b4fe2446d891023323cf89abd63be8d1b2b7a4b54136074a'
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
