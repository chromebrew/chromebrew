require 'buildsystems/autotools'

class Libtasn1 < Autotools
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.19'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libtasn1/libtasn1-4.19.0.tar.gz'
  source_sha256 '1613f0ac1cf484d6ec0ce3b8c06d56263cc7242f1c23b30d82d23de345a63f7a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7e8dc9d134572b7d5478098fd485c8e799d8bb2d3512f8ef422ec1b92474ea0',
     armv7l: 'a7e8dc9d134572b7d5478098fd485c8e799d8bb2d3512f8ef422ec1b92474ea0',
       i686: 'd7f6ece301cdc6699847ca77075c82529f2607a3485ac4c9ef947a8e34a0ebab',
     x86_64: '4d3f259d6e3e5488c31a1ba10e18c271c0734977edef5a5b2a1ec07fe0bf16fa'
  })

  # bison, diff, cmp are required at compile-time
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build
  depends_on 'glibc' # R

  configure_options '--enable-shared \
      --enable-static \
      --with-pic'
end
