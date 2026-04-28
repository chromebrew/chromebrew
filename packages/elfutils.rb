require 'buildsystems/autotools'

class Elfutils < Autotools
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.195'
  license 'GPL-2+ or LGPL-3+'
  compatibility 'all'
  source_url 'https://sourceware.org/git/elfutils.git'
  git_hashtag "elfutils-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ff4837ba7584ef891206279b5e7ed8eb47a1df45ea0445f4651cd23edf3ed6d',
     armv7l: '8ff4837ba7584ef891206279b5e7ed8eb47a1df45ea0445f4651cd23edf3ed6d',
       i686: '03cb6fd66831a2a7f974b431763211c6ce24de7e032a83074b0e030ff4737176',
     x86_64: 'a64b166958d85734e54361f65b136d7fc591ddf0ffb91dcf26f0836d3675a4c9'
  })

  depends_on 'bzip2' => :library
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'libarchive' => :executable
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  # -D_FORTIFY_SOURCE=0 needed due to -O3 optimization.
  autotools_pre_configure_options "CFLAGS+=' -Wno-error -D_FORTIFY_SOURCE=0' CXXFLAGS+=' -Wno-error -D_FORTIFY_SOURCE=0'"
  autotools_configure_options "#{'--disable-libdebuginfod --disable-debuginfod' if ARCH == 'i686'} --enable-maintainer-mode --program-prefix='eu-'"

  def self.patch
    if version == '0.195'
      patches = [
        # gawk 5.4 doesn't like C++ style comments.
        # https://sourceware.org/git/?p=elfutils.git;a=commitdiff_plain;h=c1b0ff9d92b08397b0e653a8ccefe1d1248cba57
        ['https://sourceware.org/git/?p=elfutils.git;a=commitdiff_plain;h=c1b0ff9d92b08397b0e653a8ccefe1d1248cba57',
         'ef20423278ad0330a7031e4aa7aee39fbb908ff24cfb0b690e967824645ac9c2']
      ]
      ConvenienceFunctions.patch(patches)
    end
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
