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
    aarch64: '370530cc44d12e66cf83faa17fbac1aec5e44abddcf09802d3ec83cd6863832c',
     armv7l: '370530cc44d12e66cf83faa17fbac1aec5e44abddcf09802d3ec83cd6863832c',
     x86_64: 'ebd15859bebe9ecfcf8bc954c1ae5072ff8d184b96398991478a70b3d38cd1e7'
  })

  depends_on 'xbitmaps' => :build
  depends_on 'libxcursor' => :build
  depends_on 'libxmu' => :build
end
