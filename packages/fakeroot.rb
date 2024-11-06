require 'buildsystems/autotools'

class Fakeroot < Autotools
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.35.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_#{version}.orig.tar.gz"
  source_sha256 '6a0de53b2de05277d4e6d4a884eb0de7a8ad467b82c07a6f8f2f6a629e655fdc'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64542b42054b52f1ca987a1c2974da60d6080d03a762d4e6527f0921c18031f8',
     armv7l: '64542b42054b52f1ca987a1c2974da60d6080d03a762d4e6527f0921c18031f8',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'libcap'

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074945
  pre_configure_options 'CFLAGS=-Wno-incompatible-pointer-types'
end
