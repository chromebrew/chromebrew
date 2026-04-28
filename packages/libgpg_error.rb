require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.60'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  # source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  # source_sha256 '95b178148863f07d45df0cea67e880a79b9ef71f5d230baddc0071128516ef78'
  source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f12e10130a72087790b0798458f268b5a6f9b904b32a5410357a5debe3074b3a',
     armv7l: 'f12e10130a72087790b0798458f268b5a6f9b904b32a5410357a5debe3074b3a',
       i686: '6efff3d345d804f7f38c615e31d0ad076d4ef6c92830cc4019e57f5b0f7c91a5',
     x86_64: 'ca926ab921b2d073febda3d2701896166290792f4ecdce22163dfedf68aebbb9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
