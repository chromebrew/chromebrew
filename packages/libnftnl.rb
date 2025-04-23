require 'buildsystems/autotools'

class Libnftnl < Autotools
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.2.9'
  compatibility 'all'
  source_url "https://netfilter.org/projects/libnftnl/files/libnftnl-#{version}.tar.xz"
  source_sha256 'e8c216255e129f26270639fee7775265665a31b11aa920253c3e5d5d62dfc4b8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b5d3ed470cf4c87cc251784be554f97acf61c2d98838aafc3c948064500f059',
     armv7l: '5b5d3ed470cf4c87cc251784be554f97acf61c2d98838aafc3c948064500f059',
       i686: 'cdcfca4867c1f7978fce9a0d35b8728e27545c42c174eeef412d38fc9e2c266f',
     x86_64: '1d15855fa0934eed99e18f0adfe3ad82950ec9bf1be8f72d8979b76d5714f8e5'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests
end
