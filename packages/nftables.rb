# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nftables < Autotools
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.0.9'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://netfilter.org/projects/nftables/files/nftables-1.0.9.tar.xz'
  source_sha256 'a3c304cd9ba061239ee0474f9afb938a9bb99d89b960246f66f0c3a0a85e14cd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.9_armv7l/nftables-1.0.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.9_armv7l/nftables-1.0.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nftables/1.0.9_x86_64/nftables-1.0.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bbed65ebad95e0ee11ec0ab2a1b17ecd8e33140505441f9c2d95a86ef360225b',
     armv7l: 'bbed65ebad95e0ee11ec0ab2a1b17ecd8e33140505441f9c2d95a86ef360225b',
     x86_64: '370e9eb2fe2c1bf7ee577623e8c8aa29d659336eb17ebbe3217c9b9379b5464e'
  })

  depends_on 'asciidoc' => :build
  depends_on 'glibc' # R
  depends_on 'jansson' # R
  depends_on 'libmnl' # R
  depends_on 'libnftnl' # R
  depends_on 'readline' # R

  configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
    --with-json \
    --with-cli=readline \
    --with-mini-gmp \
    --disable-debug"

  run_tests
end
