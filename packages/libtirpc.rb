require 'buildsystems/autotools'

class Libtirpc < Autotools
  description 'Libtirpc is a port of Suns Transport-Independent RPC library to Linux.'
  homepage 'https://sourceforge.net/projects/libtirpc/'
  version '1.3.8'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://downloads.sourceforge.net/project/libtirpc/libtirpc/#{version}/libtirpc-#{version}.tar.bz2"
  source_sha256 '8839959bfcc7a0f4c609d8e4f53f1c67ae33de23775ec35beb39ff15adf11920'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b55d2647b8984cf7404c20c3a6aa2f4ffee848bb989739d756abb9764068e38',
     armv7l: '3b55d2647b8984cf7404c20c3a6aa2f4ffee848bb989739d756abb9764068e38',
       i686: '662adf4a07f4df52a71ec5a7098676e3865fc50c48794ef534037c1e1e964b3c',
     x86_64: '081acfd9da4eeda100fcbe9f538f7af4ba1531b13c31f4662395cf9d50c73ac4'
  })

  depends_on 'e2fsprogs' => :library
  depends_on 'glibc' => :library
  depends_on 'krb5' => :library
end
