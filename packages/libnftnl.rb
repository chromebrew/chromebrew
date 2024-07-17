require 'buildsystems/autotools'

class Libnftnl < Autotools
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.2.7'
  compatibility 'all'
  source_url "https://netfilter.org/projects/libnftnl/files/libnftnl-#{version}.tar.xz"
  source_sha256 '9122774f968093d5c0bacddd67de480f31fa4073405a7fc058a34b0f387aecb3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e063c6205897f01460d0fa1692cdc458197588f483332f90e8f88f75f890c420',
     armv7l: 'e063c6205897f01460d0fa1692cdc458197588f483332f90e8f88f75f890c420',
       i686: '1377c81d11c0c7c5a32b0c75a72b54ecc2ad3f5c46cee733ba24d3dfb027f79f',
     x86_64: '534d939421b14d0063b07af88ba7251b8255d122aa197303334a7726576d683a'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests
end
