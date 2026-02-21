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
    aarch64: 'ac27e5b22d610883597044e05b090d068264abe987d74150d63415f3c48b88a6',
     armv7l: 'ac27e5b22d610883597044e05b090d068264abe987d74150d63415f3c48b88a6',
       i686: '2ff85a2480832c7b0cff9e0b35134da1eafdc4880a2214fea9ca79d16df42a59',
     x86_64: 'a1c3e80e55dffc3e1e9503a87552d38a34fbb3fc83bbf7eadf359c154a9bef2e'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' # R
  depends_on 'libarchive' => :executable_only
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
