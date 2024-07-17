# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nftables < Autotools
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.1.0'
  license 'GPL2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://netfilter.org/projects/nftables/files/nftables-#{version}.tar.xz"
  source_sha256 'ef3373294886c5b607ee7be82c56a25bc04e75f802f8e8adcd55aac91eb0aa24'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25b41af243ada6343ee8805e2e50b8dfcba33a6c65ef9f66c40fb6003146e3a0',
     armv7l: '25b41af243ada6343ee8805e2e50b8dfcba33a6c65ef9f66c40fb6003146e3a0',
     x86_64: 'bd633d09e225c49097d1e5f10bb97fd3371cb75c4b498ef8df4f6a6e5b7b2cc4'
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
