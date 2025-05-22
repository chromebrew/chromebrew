require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.51'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  source_sha256 'be0f1b2db6b93eed55369cdf79f19f72750c8c7c39fc20b577e724545427e6b2'
  # source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  # git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8fe6fdb8928a22265df0600546a35a6ea2b6a6cf17bf26a1b18612ee636919a2',
     armv7l: '8fe6fdb8928a22265df0600546a35a6ea2b6a6cf17bf26a1b18612ee636919a2',
       i686: '2b4ebddce4b78f777f64e8759466c4b6de3bdcf1b8fce7658faf51578229519a',
     x86_64: '3abfb43e3f122fd4d97e9718ed29173e8417dc554cf80fea2e00ec44731af438'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
