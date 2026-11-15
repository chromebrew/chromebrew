require 'buildsystems/autotools'

class Libnftnl < Autotools
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  license 'GPL-2'
  version '1.3.2'
  compatibility 'all'
  source_url "https://netfilter.org/projects/libnftnl/files/libnftnl-#{version}.tar.xz"
  source_sha256 'c97abc3409f8fa396b4462b2bb7f147a3a47a4ddc97cfa0b2f18890c9cfde8b0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b75be7f10fd897198a22f968b5c6253d9b462482730713c7bd676bf42139ee48',
     armv7l: 'b75be7f10fd897198a22f968b5c6253d9b462482730713c7bd676bf42139ee48',
       i686: '08051784083f4af1062811079dd781b7a8fa4c570a8455d35ce88924dc4d344c',
     x86_64: '50452dd617f5794ba9bf26405fec3115ff60cf593517a0574e816c50f4fe0f6f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libmnl' => :library

  run_tests
end
