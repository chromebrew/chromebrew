require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.50'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51db693aa0dab551e2fcb16c3e3d211d066622b96cb9ea9b92d96f3c417e6db9',
     armv7l: '51db693aa0dab551e2fcb16c3e3d211d066622b96cb9ea9b92d96f3c417e6db9',
       i686: '2df8a712ffa343dc6436b32abdbfc8c0e9b82aa882a9e36eabc61170dce3955a',
     x86_64: '2e679a95c7a6a65ed00f7253af01db9a849d3b62760efa767533632cf228f5b9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Docs fail to build otherwise.
  configure_options '--enable-maintainer-mode'
end
