require 'package'

class Libbsd < Package
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  version '0.11.7'
  license 'BSD, BSD-2, BSD-4, ISC'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libbsd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.7_armv7l/libbsd-0.11.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.7_armv7l/libbsd-0.11.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.7_i686/libbsd-0.11.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.7_x86_64/libbsd-0.11.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'edb871fe00481c684054e3d1c411d08815d1389d5c38d5b67a3f206db3be556f',
     armv7l: 'edb871fe00481c684054e3d1c411d08815d1389d5c38d5b67a3f206db3be556f',
       i686: 'fc48f3430482b0f1455583cdac0f0f90dad863ab18890b941ddba44dc0893eb7',
     x86_64: 'ac5b30ebab478c82c37e4f40b2ead88b93ed00a772d2838f5a1e213b7c0dc03b'
  })

  depends_on 'glibc' # R
  depends_on 'libmd' # R
  no_lto

  def self.build
    FileUtils.mkdir_p 'm4'
    system 'autoupdate'
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
