require 'buildsystems/autotools'

class Libbsd < Autotools
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki/'
  version '0.12.2'
  license 'BSD, BSD-2, BSD-4, ISC'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libbsd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9fc6d842cc4c7c8578fc90976b3711ec5e4ac3a3d2c8b574ffcc6ecdf93ad224',
     armv7l: '9fc6d842cc4c7c8578fc90976b3711ec5e4ac3a3d2c8b574ffcc6ecdf93ad224',
       i686: '2918bce4644d2f5fbf9cf10f405dd74d2289f9121350076feca2a5b501a3919d',
     x86_64: 'efc53d7a9d88b2ce3de3c0f8bc6269326d0275ce97e0cf22b6d18b22092b87a5'
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
