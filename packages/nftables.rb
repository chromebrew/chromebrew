# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nftables < Autotools
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.1.6'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://netfilter.org/projects/nftables/files/nftables-#{version}.tar.xz"
  source_sha256 '372931bda8556b310636a2f9020adc710f9bab66f47efe0ce90bff800ac2530c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2470463856096c2d2d477bbc5f08e70784d7d8a02c172df73fcb255f348c89d4',
     armv7l: '2470463856096c2d2d477bbc5f08e70784d7d8a02c172df73fcb255f348c89d4',
     x86_64: 'a20f5b03c0ce6a54d4183546b90cffcad22bbd59638dbb2b732b28f4726f4dd2'
  })

  depends_on 'glibc' # R
  depends_on 'jansson' # R
  depends_on 'libmnl' # R
  depends_on 'libnftnl' # R
  depends_on 'libxslt' => :build
  depends_on 'py3_asciidoc' => :build
  depends_on 'readline' # R

  autotools_configure_options "--sysconfdir=#{CREW_PREFIX}/etc \
    --with-json \
    --with-cli=readline \
    --with-mini-gmp \
    --disable-debug"

  # run_tests

  # FAIL: tests/build/run-tests.sh
  # FAIL: tests/json_echo/run-test.py
  # SKIP: tests/monitor/run-tests.sh
  # SKIP: tests/py/nft-test.py
  # ERROR: tests/shell/run-tests.sh
  # ============================================================================
  # Testsuite summary for nftables 1.1.6
  # ============================================================================
  # TOTAL: 5
  # PASS:  0
  # SKIP:  2
  # XFAIL: 0
  # FAIL:  2
  # XPASS: 0
  # ERROR: 1
end
