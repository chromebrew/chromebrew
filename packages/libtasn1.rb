require 'buildsystems/autotools'

class Libtasn1 < Autotools
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.21.0'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libtasn1/libtasn1-#{version}.tar.gz"
  source_sha256 '1d8a444a223cc5464240777346e125de51d8e6abf0b8bac742ac84609167dc87'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbc90c7aeddcbf2ec97ebb5d633d1555d6d2bb42a9170be8398f96c437d1ee23',
     armv7l: 'bbc90c7aeddcbf2ec97ebb5d633d1555d6d2bb42a9170be8398f96c437d1ee23',
       i686: '3a420af07e96de2da8200f4c6a85384de0484a552ade20bb86086ce5ad1a2f08',
     x86_64: 'fc012646fadabff15bacccd484132156022d47f2b068f310df491d28d18ba684'
  })

  # bison, diff, cmp are required at compile-time
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build
  depends_on 'glibc' # R

  autotools_configure_options '--enable-shared \
      --enable-static \
      --with-pic'
end
