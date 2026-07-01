require 'buildsystems/autotools'

class Gpgme < Autotools
  description 'GnuPG Made Easy (GPGME) is a library designed to make access to GnuPG easier for applications.'
  homepage 'https://www.gnupg.org/related_software/gpgme/index.html'
  version '2.1.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-#{version}.tar.bz2"
  source_sha256 '0687a95b299871c4141f507c0f740de6b429c9ac067d0fa4e062e3264df5fb77'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31e4811987eb899014349372b2543b84a903209fec619699fa1cb64e800b0e3d',
     armv7l: '31e4811987eb899014349372b2543b84a903209fec619699fa1cb64e800b0e3d',
       i686: '2e080c4c730bb88cc0e474035de8c0f63755ff48702d0f80191b2aa107a09b2f',
     x86_64: 'bc20157033926aac0e5239b546b71de68156f79ca5f7648f7476f99bc35ca474'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnupg' => :logical
  depends_on 'libassuan' => :library
  depends_on 'libgpg_error' => :library
end
