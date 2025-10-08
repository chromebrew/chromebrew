require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.56'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  # source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  # source_sha256 '95b178148863f07d45df0cea67e880a79b9ef71f5d230baddc0071128516ef78'
  source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2004011a4aa419e3186447795efdef977367ba6b5942fec9253f8e9ff91c3560',
     armv7l: '2004011a4aa419e3186447795efdef977367ba6b5942fec9253f8e9ff91c3560',
       i686: '2a14c312b172c577c72e828a50b043b3771e1b2db64d707e312379396d257460',
     x86_64: '4ad701e5a4b5dfab64cc39ffddf3ad5c864ce8f1c6d1607007e0664925240479'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
