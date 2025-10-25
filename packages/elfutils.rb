require 'buildsystems/autotools'

class Elfutils < Autotools
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.194'
  license 'GPL-2+ or LGPL-3+'
  compatibility 'all'
  source_url 'https://sourceware.org/git/elfutils.git'
  git_hashtag "elfutils-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '782a98a8e6d23b5e7f92c80a42be8c946b0c9ad58bd552f88e3e9f0863b223ed',
     armv7l: '782a98a8e6d23b5e7f92c80a42be8c946b0c9ad58bd552f88e3e9f0863b223ed',
       i686: 'e24f749b79bf1e812510e34414b489af0758b6bc4ac4c60234ffbde5efdcf9ab',
     x86_64: 'd00107142ef6e7cf84cd2d2e5fbc6113464b2e86d4044606c3950a0692e7f86f'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libarchive' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  # -D_FORTIFY_SOURCE=0 needed due to -O3 optimization.
  autotools_pre_configure_options "CFLAGS+=' -Wno-error -D_FORTIFY_SOURCE=0' CXXFLAGS+=' -Wno-error -D_FORTIFY_SOURCE=0'"
  autotools_configure_options "#{'--disable-libdebuginfod --disable-debuginfod' if ARCH == 'i686'} --enable-maintainer-mode --program-prefix='eu-'"

  def self.patch
    return unless ARCH == 'i686'

    # https://sourceware.org/git/?p=glibc.git;a=commit;h=0be74c5c7cb239e4884d1ee0fd48c746a0bd1a65
    FileUtils.install "#{CREW_PREFIX}/include/fts.h", 'src/fts.h', mode: 0o644
    system "sed -i 's/__REDIRECT (fts_set, (FTS \\*, FTSENT \\*, int), fts64_set) __THROW;/__REDIRECT_NTH (fts_set, (FTS \\*, FTSENT \\*, int), fts64_set);/' src/fts.h"
    system "sed -i 's,#include <fts.h>,#include \"fts.h\",' src/srcfiles.cxx"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # These files cause a fork bomb when they are invoked from /usr/local/etc/profile
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/etc/profile.d/debuginfod.csh"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/etc/profile.d/debuginfod.sh"
  end
end
