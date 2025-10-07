require 'buildsystems/autotools'

class Xsetroot < Autotools
  description 'Root window parameter setting utility for X'
  homepage 'https://www.x.org/archive/X11R7.5/doc/man/man1/xsetroot.1.html'
  version '1.1.3'
  license 'MIT-with-advertising'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xsetroot.git'
  git_hashtag "xsetroot-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ccabb9f3c58eb88df8eb937d8be5171d73e6ac3051ac2ff7cfad156abeb8d9ea',
     armv7l: 'ccabb9f3c58eb88df8eb937d8be5171d73e6ac3051ac2ff7cfad156abeb8d9ea',
     x86_64: '20a40300aff5dd5eb990a7bfd3e28e1805dd4db15373104a93ce9eb1360c9afb'
  })

  depends_on 'xbitmaps' => :build
  depends_on 'libxcursor' => :build
  depends_on 'libxmu' => :build
end
