require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.58'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  # source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  # source_sha256 '95b178148863f07d45df0cea67e880a79b9ef71f5d230baddc0071128516ef78'
  source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '805b6f751948d0f8471fc8dcab33797e8ff0ad036413a33f1e5d2813b2e9d7fe',
     armv7l: '805b6f751948d0f8471fc8dcab33797e8ff0ad036413a33f1e5d2813b2e9d7fe',
       i686: 'cebd41e587baa010d4c4ed4d04d7eceb7fa223eabfd6b265a9185ce711376676',
     x86_64: 'a5dfd48d49047a1461156ebf8f589c661af00f1925a0515577ca16eb6a183049'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
