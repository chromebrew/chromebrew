require 'buildsystems/autotools'

class Fakeroot < Autotools
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '2.0'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_#{version}.orig.tar.gz"
  source_sha256 '562d951828887e5ccc31489248feae62f334a16c3d81fe6592f34016ffb02636'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '430a540c1e85576cc484e0033aa9f2e9bf38844bf674316cb056e868e233df02',
     armv7l: '430a540c1e85576cc484e0033aa9f2e9bf38844bf674316cb056e868e233df02',
       i686: '03c4860b32625966f958699d0702eac7a3505887fbc299249b5bf8ea01dfb6e4',
     x86_64: 'e10acd2722f9c0983b3de3d459d59fd2293f8e4794cd85d5206d095444c0557a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcap'

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074945
  autotools_pre_configure_options 'CFLAGS=-Wno-incompatible-pointer-types'
end
