require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.57'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  # source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  # source_sha256 '95b178148863f07d45df0cea67e880a79b9ef71f5d230baddc0071128516ef78'
  source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c73d847991b6756b110430d451c375d53c86cd371f95b9ec7b088fd089db46f4',
     armv7l: 'c73d847991b6756b110430d451c375d53c86cd371f95b9ec7b088fd089db46f4',
       i686: 'a9f5cc9555f2211aa1f2f5a8b8bad6027decca051e2d281b2516e6caad679a73',
     x86_64: 'b9e6c3f3e1860a74f1a4b182c5ebd7696cee8d4d9a41742434ffe9f39cecd238'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
