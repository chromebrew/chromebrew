require 'buildsystems/autotools'

class Fakeroot < Autotools
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.37.1.2'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_#{version}.orig.tar.gz"
  source_sha256 '959496928c8a676ec8377f665ff6a19a707bfad693325f9cc4a4126642f53224'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51a0e401806e8102e06eef577a7edf927c13df93f0823f45c2c15fa28610d7e2',
     armv7l: '51a0e401806e8102e06eef577a7edf927c13df93f0823f45c2c15fa28610d7e2',
       i686: '37cd31b4ddebe9bf6a4928e9d1dd60fef33a6f29407d331d9257b265b31d7f14',
     x86_64: 'bf8e53c22d7df9c5c08b971220b6d627b3255b69b73226e88363edca8041581a'
  })

  depends_on 'glibc' # R
  depends_on 'libcap'

  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074945
  autotools_pre_configure_options 'CFLAGS=-Wno-incompatible-pointer-types'
end
