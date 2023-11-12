require 'buildsystems/autotools'

class Gpgme < Autotools
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '1.23.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 'a0c316f7ab7d3bfb01a8753c3370dc906e5b61436021f3b54ff1483b513769bd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.23.1_armv7l/gpgme-1.23.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.23.1_armv7l/gpgme-1.23.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.23.1_i686/gpgme-1.23.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gpgme/1.23.1_x86_64/gpgme-1.23.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '96d70618ccb2cf94a2e4dca0a14d6b3626f62103fecad7e539f722c9e8502280',
     armv7l: '96d70618ccb2cf94a2e4dca0a14d6b3626f62103fecad7e539f722c9e8502280',
       i686: '8937411c7a2355a112103cba225b7c32cf672ae571a3c6641197ecd4434b6fce',
     x86_64: 'd10b89f8f098af4862523bea4d6b58585c45cf9010c07b26bc540f0cbfbe883f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gnupg' # L
  depends_on 'libassuan' # R
  depends_on 'libgpgerror' # R
end
