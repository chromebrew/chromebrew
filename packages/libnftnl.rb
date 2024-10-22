require 'buildsystems/autotools'

class Libnftnl < Autotools
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.2.8'
  compatibility 'all'
  source_url "https://netfilter.org/projects/libnftnl/files/libnftnl-#{version}.tar.xz"
  source_sha256 '37fea5d6b5c9b08de7920d298de3cdc942e7ae64b1a3e8b880b2d390ae67ad95'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c093a2a0cbee0292fb2e0d41bc54181b79e8105bbebb076782a9c160c6d6006',
     armv7l: '7c093a2a0cbee0292fb2e0d41bc54181b79e8105bbebb076782a9c160c6d6006',
       i686: 'c003b4116ed6c4a5e2f9abc8400f96a4312e16446d957a0a3f2865541b2cb982',
     x86_64: '2a276eb55a9671e9314dd161e5605e8719222ff37b4beda1668614816309686f'
  })

  depends_on 'glibc' # R
  depends_on 'libmnl' # R

  run_tests
end
