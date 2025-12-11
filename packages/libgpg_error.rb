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
    aarch64: '39da8b9fe114a779d082d4354bd6b76bc90e7959ca8b69bb2be45cb0f255bdb2',
     armv7l: '39da8b9fe114a779d082d4354bd6b76bc90e7959ca8b69bb2be45cb0f255bdb2',
       i686: '16c159fe9b1352f0e0805099d2ea2013b746ee3621645d300211e7dad124d079',
     x86_64: '16503f0ff1003dacfa400f8051d4b21b28f30d9346bd0c88aac50879371e072c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
