require 'buildsystems/autotools'

class Libnftnl < Autotools
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.3.1'
  compatibility 'all'
  source_url "https://netfilter.org/projects/libnftnl/files/libnftnl-#{version}.tar.xz"
  source_sha256 '607da28dba66fbdeccf8ef1395dded9077e8d19f2995f9a4d45a9c2f0bcffba8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69fbc6d3e87b6ab94d075fa96f90fce53e82912f6aef5548879d7f758b172f77',
     armv7l: '69fbc6d3e87b6ab94d075fa96f90fce53e82912f6aef5548879d7f758b172f77',
       i686: '37260df5b9c20e694c0a63e817bf01121d8d6a6de536e9dd5e8015f924808717',
     x86_64: 'b79d2fc5da8360508f1aa0fe9aeb90d9f7655c38efcd16c62c53be3ca7d4cef4'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests
end
