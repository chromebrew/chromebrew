require 'buildsystems/autotools'

class Makedepend < Autotools
  description 'Makedepend parses C sources in Makefiles to generate dependency lists'
  homepage 'https://www.x.org/wiki/'
  version '1.0.9'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.x.org/releases/individual/util/makedepend-#{version}.tar.gz"
  source_sha256 'bc94ffda6cd4671603a69c39dbe8f96b317707b9185b2aaa3b54b5d134b41884'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec484d9e47ff6589d95f8e17e21d39612ff425c3aaf10e1b1a7979e569f41b39',
     armv7l: 'ec484d9e47ff6589d95f8e17e21d39612ff425c3aaf10e1b1a7979e569f41b39',
     x86_64: '9fe4ef118e76ad82de09442d72d2894fd2888470ca8afcec898459cb6c7e40f2'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libx11'

  autotools_configure_options '--without-lint'
end
