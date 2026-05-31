require 'buildsystems/cmake'

class Gpgmepp < CMake
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '2.1.0'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://gnupg.org/ftp/gcrypt/gpgmepp/gpgmepp-#{version}.tar.xz"
  source_sha256 '57f804468f0204504b172c6b139cb05124b4263be7ad514932c7c4c5062a16e2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a1305e6de650d2242e91eb328965601d9cd0ee2c67019fdd527621c03ad97cfe',
     armv7l: 'a1305e6de650d2242e91eb328965601d9cd0ee2c67019fdd527621c03ad97cfe',
       i686: '6619d9625897f3c54785edbbf7d0762072b44203ef3abab26524a6634d9627db',
     x86_64: 'b93d050b9e68df2089e1cb272a0ff852442acec98d2b630ac875247db1d28e05'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gpgme' => :library
  depends_on 'libgpg_error' => :library
end
