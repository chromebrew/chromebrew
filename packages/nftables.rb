# Adapted from Arch Linux nftables PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/nftables/trunk/PKGBUILD

require 'buildsystems/autotools'

class Nftables < Autotools
  description 'Netfilter tables userspace tools'
  homepage 'https://netfilter.org/projects/nftables/'
  version '1.1.7'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://netfilter.org/projects/nftables/files/nftables-#{version}.tar.xz"
  source_sha256 'a6fbf060d8d4fff001517a2b94f356bb4366bfbf0ba366366f9d27cc38caa58f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c82ab77c7f8a9b3ed78b6881bcd65ddd01bbc563551392808fbc5ee9f0a14f77',
     armv7l: 'c82ab77c7f8a9b3ed78b6881bcd65ddd01bbc563551392808fbc5ee9f0a14f77',
     x86_64: '7ab0fe2025bc93ed62792c9b3b168726f94b029a072f98d8d72ddbabeac20465'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jansson' => :library
  depends_on 'libmnl' => :library
  depends_on 'libnftnl' => :library
  depends_on 'libxslt' => :build
  depends_on 'py3_asciidoc' => :build
  depends_on 'readline' => :library

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
