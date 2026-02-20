require 'buildsystems/autotools'

class M4 < Autotools
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.21'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/gnu/m4/m4-#{version.split('-').first}.tar.xz"
  source_sha256 '664f2b1654c363a6348b688d5d475ed9ec0e7ef3c72f6f315f37fe97a2fe63eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a6796ad0c6e6acad255add6cbfd757005fcec8f2668c7898d138cabf51dfb32',
     armv7l: '5a6796ad0c6e6acad255add6cbfd757005fcec8f2668c7898d138cabf51dfb32',
       i686: 'fb8e1c34214420b6a9a4a1acce3d2e2ed13b4e49dfede396060fdc3de005cc3f',
     x86_64: '2ffed7ee8131ea0757f140cfb6ed1559463243d6b8049ded703c1cea28fbff39'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'libsigsegv' => :build
end
