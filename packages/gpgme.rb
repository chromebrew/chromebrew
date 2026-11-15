require 'buildsystems/autotools'

class Gpgme < Autotools
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '2.2.0'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 '7160e80e84dafd00d956c84891c533bb7ab16a6a54fbe1574b2f3acf0496977b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc30d9eb9124849194fb345ec8336f26f67c0a932b43a9a15a7514b48f74897c',
     armv7l: 'dc30d9eb9124849194fb345ec8336f26f67c0a932b43a9a15a7514b48f74897c',
       i686: '21d1d74c32cfd55b08b272cc373383320b3eb5bd8f5a82688bbd824fc988920e',
     x86_64: 'd1b8631e233aae1da4a17d54a3993e8240b65e780c47b3f16c6bc9fc9195f61f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnupg' => :logical
  depends_on 'libassuan' => :library
  depends_on 'libgpg_error' => :library
end
