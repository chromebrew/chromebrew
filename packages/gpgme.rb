require 'buildsystems/autotools'

class Gpgme < Autotools
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '2.1.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 '6d7ee12b209d7dce75468db53f72a90e1ad3d21f4c304ef2c002612a52f5333a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '84e8200efddd29c6737477b5507fdefb931932e58503f3140cd2a3b0904b9373',
     armv7l: '84e8200efddd29c6737477b5507fdefb931932e58503f3140cd2a3b0904b9373',
       i686: '4d9695fe62577326a933b5d2e56af21cd773ebbe0276d36e9bf03ed0c2d534db',
     x86_64: '3f71e5c09a037877099d96d1f395dc8573ad9faffcc949f93e7d7ebdeb38a8b1'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnupg' => :logical
  depends_on 'libassuan' => :library
  depends_on 'libgpg_error' => :library
end
