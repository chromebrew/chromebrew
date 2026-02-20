require 'buildsystems/autotools'

class Libgpg_error < Autotools
  description 'Libgpg-error is a small library that defines common error values for all GnuPG components.'
  homepage 'https://www.gnupg.org/related_software/libgpg-error/index.html'
  version '1.59'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  # source_url "https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-#{version}.tar.bz2"
  # source_sha256 '95b178148863f07d45df0cea67e880a79b9ef71f5d230baddc0071128516ef78'
  source_url 'https://dev.gnupg.org/source/libgpg-error.git'
  git_hashtag "libgpg-error-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0aeed8bfaa8decd113253e4fb0a0f6a26abad8f6d06b590202735fee6e19d3c1',
     armv7l: '0aeed8bfaa8decd113253e4fb0a0f6a26abad8f6d06b590202735fee6e19d3c1',
       i686: '229950f1911365734f5123361f87a09fb9dc739b40f7e94f0740c1f2b4d3c0be',
     x86_64: '9850780c116552dd80be130cd370d9336a574627b269cad7f9e99eef40dd90ab'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  # Docs fail to build otherwise.
  autotools_configure_options '--enable-maintainer-mode'
end
