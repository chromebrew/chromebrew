require 'buildsystems/autotools'

class Hello < Autotools
  description 'GNU Hello is another implementation of the classic program that prints “Hello, world!”'
  homepage 'https://www.gnu.org/software/hello/'
  version '2.12.3'
  license 'FDL-1.3 GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/hello/hello-#{version}.tar.gz"
  source_sha256 '0d5f60154382fee10b114a1c34e785d8b1f492073ae2d3a6f7b147687b366aa0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c63124375c8ab30bbea41bee61adc596b8f48438ea3f805825e68922c61de952',
     armv7l: 'c63124375c8ab30bbea41bee61adc596b8f48438ea3f805825e68922c61de952',
       i686: 'fc0abcba774d6763f2dc7f0b5a459523132800e0baed90188def92968ebf2573',
     x86_64: '6f098bd789a71eb5c5a64d6aaf735a798f421f46ee8ade36d1fa22a3ead4f58c'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
end
