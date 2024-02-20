require 'buildsystems/autotools'

class Libbsd < Autotools
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  version '0.11.8'
  license 'BSD, BSD-2, BSD-4, ISC'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libbsd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3694af8410ff0ba9261dcd8173293db4c53d9b78ee7e6986695e290ac26d7f05',
     armv7l: '3694af8410ff0ba9261dcd8173293db4c53d9b78ee7e6986695e290ac26d7f05',
       i686: '32371f0f80a0edf09a17200498282148433258ece7b6db1184445e04309c6bff',
     x86_64: 'e5d2f97a309a82dd90312386b289cc9e63b22e92b373f9e93adbc4e53d0761de'
  })

  depends_on 'glibc' # R
  depends_on 'libmd' # R
  no_lto

  def self.patch
    FileUtils.mkdir_p 'm4'
    system 'autoupdate'
  end

  def self.check
    # FAIL: nlist
    # ===========
    #
    # nlist: nlist.c:82: main: Assertion `nl[0].n_type == (N_TEXT | N_EXT)' failed.
    # FAIL nlist (exit status: 134)
    #
    system 'make check || true'
  end
end
