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
    aarch64: '7c093a2a0cbee0292fb2e0d41bc54181b79e8105bbebb076782a9c160c6d6006',
     armv7l: '7c093a2a0cbee0292fb2e0d41bc54181b79e8105bbebb076782a9c160c6d6006',
       i686: 'cdcfca4867c1f7978fce9a0d35b8728e27545c42c174eeef412d38fc9e2c266f',
     x86_64: '2a276eb55a9671e9314dd161e5605e8719222ff37b4beda1668614816309686f'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests
end
