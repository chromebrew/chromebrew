require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.61'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  # source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  # source_sha256 '95b178148863f07d45df0cea67e880a79b9ef71f5d230baddc0071128516ef78'
  source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3739b9aa77e080731e9c87d4f7c1cdd5b4a7e8c3223717597426113e6c1485a',
     armv7l: 'a3739b9aa77e080731e9c87d4f7c1cdd5b4a7e8c3223717597426113e6c1485a',
       i686: '7c7349dc251c6cf711107cbfcfa9883cc8f1d95919b7c281e0a699137ab767b6',
     x86_64: '415c536fa4e9972f01f0b4c58cbbd3bb8cb8893cdb1d6efc767d59a949aa7d6b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
