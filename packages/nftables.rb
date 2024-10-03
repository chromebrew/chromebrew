# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nftables < Autotools
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.1.1'
  license 'GPL2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://netfilter.org/projects/nftables/files/nftables-#{version}.tar.xz"
  source_sha256 '6358830f3a64f31e39b0ad421d7dadcd240b72343ded48d8ef13b8faf204865a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ef8444cc26ca8958a118ab23214ee1c93e4c8a82be3d3ee9d94378665b29bba',
     armv7l: '9ef8444cc26ca8958a118ab23214ee1c93e4c8a82be3d3ee9d94378665b29bba',
     x86_64: '64193fb122b88b0aa0c66fa65ac20c9e10aaafb55b40f459b204b08c785b4b19'
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
