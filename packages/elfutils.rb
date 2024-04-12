require 'buildsystems/autotools'

class Elfutils < Autotools
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.191'
  license 'GPL-2+ or LGPL-3+'
  compatibility 'all'
  source_url 'https://sourceware.org/git/elfutils.git'
  git_hashtag "elfutils-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '818e00b257bc8aecc944da511ca0ce159d5d9836be118a813078a9ceff58bd1b',
     armv7l: '818e00b257bc8aecc944da511ca0ce159d5d9836be118a813078a9ceff58bd1b',
       i686: '1e5061a8f1448225d91546f5428fdf9e5d01966074512e16cce3fd6f3214046a',
     x86_64: '5090210bdc4f451e69c994b9d6e5a23241f4cce6a38870a27f0cc66c82fe8213'
  })

  depends_on 'bzip2' # R
  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libarchive' # R
  depends_on 'libmicrohttpd' # R
  depends_on 'sqlite' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  pre_configure_options "CFLAGS+=' -Wno-error ' CXXFLAGS+=' -Wno-error '"
  configure_options "#{ARCH == 'i686' ? '--disable-libdebuginfod --disable-debuginfod' : ''} --enable-maintainer-mode --program-prefix='eu-'"

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
