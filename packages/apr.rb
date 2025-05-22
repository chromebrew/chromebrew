require 'buildsystems/autotools'

class Apr < Autotools
  description 'The mission of the Apache Portable Runtime (APR) project is to create and maintain software libraries that provide a predictable and consistent interface to underlying platform-specific implementations.  APR is the base portability library.'
  homepage 'https://apr.apache.org/'
  version '1.7.5'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://dlcdn.apache.org/apr/apr-#{version}.tar.bz2"
  source_sha256 'cd0f5d52b9ab1704c72160c5ee3ed5d3d4ca2df4a7f8ab564e3cb352b67232f2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f87428e564b81cb430f250a91f10e8e161d53cfa9919802eecd4c871ab8be54a',
     armv7l: 'f87428e564b81cb430f250a91f10e8e161d53cfa9919802eecd4c871ab8be54a',
       i686: '0b61996688a957a0f4a9101fc218665bdff14429a921254a65d03e6d4a345a1b',
     x86_64: 'c5f65c79ac2dc3942a024a42caafca2a8777f02bcafe23ad751de564de14c8d0'
  })

  depends_on 'util_linux' # R

  # https://bz.apache.org/bugzilla/show_bug.cgi?id=63439
  autotools_configure_options '--with-devrandom --without-sendfile --enable-layout=GNU'
end
