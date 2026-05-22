require 'buildsystems/autotools'

class Fakeroot < Autotools
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.38.1'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_#{version}.orig.tar.gz"
  source_sha256 '37c5063942efe2e2aeefd6e71ae2690bcb9b7d512c53bc6409b54d0730cbdac1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a11831f227bab699b3398ca1dcffbf72a2a9c2274e1d1f44813f6d5bdc14842',
     armv7l: '5a11831f227bab699b3398ca1dcffbf72a2a9c2274e1d1f44813f6d5bdc14842',
       i686: '7b96a5f92f8b6260203f7c34d71c07266e37e21a75a089bea3620578f3574bae',
     x86_64: '08c97f2533ad57f2d398bc58605e8812dff1d08d17b58e515e2f7218920df0bf'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcap'

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074945
  autotools_pre_configure_options 'CFLAGS=-Wno-incompatible-pointer-types'
end
