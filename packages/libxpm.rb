require 'buildsystems/autotools'

class Libxpm < Autotools
  description 'X.org X Pixmap Library'
  homepage 'https://www.x.org'
  version '3.5.17'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libXpm-3.5.17.tar.gz'
  source_sha256 '959466c7dfcfcaa8a65055bfc311f74d4c43d9257900f85ab042604d286df0c6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da3350241e31845678e96ca3243548d124fcf2bb6b3bd4f9a3b59f5c319e9c75',
     armv7l: 'da3350241e31845678e96ca3243548d124fcf2bb6b3bd4f9a3b59f5c319e9c75',
       i686: 'b9f705c20bb811aa061235efe4bc0465ca55a0b4f8fe2ae1c159c4aa07b73a98',
     x86_64: '2c6f22c349834a065216bd1b765d0257613503f36e7dd2c0b11e108dddc91fbd'
  })

  depends_on 'libx11'
  depends_on 'util_macros'
  depends_on 'gettext'
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'ncompress' => :build
  depends_on 'gcc_lib' # R
end
