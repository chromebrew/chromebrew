require 'buildsystems/autotools'

class Openssh < Autotools
  description 'OpenSSH is the premier connectivity tool for remote login with the SSH protocol.'
  homepage 'https://www.openssh.com/'
  version '10.6p2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url "https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-#{version}.tar.gz"
  source_sha256 '9ae44872090cf2f06b3cf9ff147e7f16f309671340763ed2f99248398ae29d5b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '71b4cc5c029169b0295bef8bfca13c42c829920cf8dc6b4d8ecd37582bd66437',
     armv7l: '71b4cc5c029169b0295bef8bfca13c42c829920cf8dc6b4d8ecd37582bd66437',
       i686: '5fc1543c76d4d93fdc48fde8b6756c09355d0f0288d7d5071842600f52440f2b',
     x86_64: 'c21e96cec43780769b18e6e26838e8eb391fe069c751243ba6ea0f1b9af5ac9a'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libmd' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'libxcrypt' => :logical
  depends_on 'openssl' => :executable
  depends_on 'zlib' => :executable

  autotools_configure_options '--enable-year2038 --without-hardening --without-retpoline'
end
