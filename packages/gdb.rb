# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'package'

class Gdb < Package
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '12.1-a4418a9-py3.11'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/bminor/binutils-gdb.git'
  git_hashtag 'a4418a9c6f99fd31c51698b1f6a6f8dbc1b81b6f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-a4418a9-py3.11_armv7l/gdb-12.1-a4418a9-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-a4418a9-py3.11_armv7l/gdb-12.1-a4418a9-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-a4418a9-py3.11_i686/gdb-12.1-a4418a9-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-a4418a9-py3.11_x86_64/gdb-12.1-a4418a9-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cdacd167edef7d56254298d1169551996b2910d1dcc97111fbb0740307f60154',
     armv7l: 'cdacd167edef7d56254298d1169551996b2910d1dcc97111fbb0740307f60154',
       i686: '87a1644e64b00b86aeed1dd00e6081314129a4658f9609fc2b9aaff06d388809',
     x86_64: 'a88eabe0cceb8bd0d87d6c54dfb70922e7d810af4629e49cb91b7bf99f7f70d6'
  })

  depends_on 'boost' # R
  depends_on 'elfutils' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'mpfr' # R
  depends_on 'ncurses' # R
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'source_highlight' # R
  depends_on 'xxhash' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  def self.patch
    @readline8patch = <<~READLINE8_PATCH_EOF
      commit 1add37b567a7dee39d99f37b37802034c3fce9c4
      Author: Andreas Schwab <schwab@linux-m68k.org>
      Date:   Sun Mar 20 14:01:54 2022 +0100

          Add support for readline 8.2

          In readline 8.2 the type of rl_completer_word_break_characters changed to
          include const.

      diff --git a/gdb/completer.c b/gdb/completer.c
      index d3900ae2014..a51c16ac7f8 100644
      --- a/gdb/completer.c
      +++ b/gdb/completer.c
      @@ -36,7 +36,7 @@
          calling a hook instead so we eliminate the CLI dependency.  */
       #include "gdbcmd.h"

      -/* Needed for rl_completer_word_break_characters() and for
      +/* Needed for rl_completer_word_break_characters and for
          rl_filename_completion_function.  */
       #include "readline/readline.h"

      @@ -2011,7 +2011,7 @@ gdb_completion_word_break_characters_throw ()
             rl_basic_quote_characters = NULL;
           }

      -  return rl_completer_word_break_characters;
      +  return (char *) rl_completer_word_break_characters;
       }

       char *
    READLINE8_PATCH_EOF
    File.write('upstream-fix-build-readline8.patch', @readline8patch)
    system 'patch -Np1 -i upstream-fix-build-readline8.patch'
  end

  def self.build
    FileUtils.mkdir_p 'build'
    Dir.chdir('build') do
      system "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw  -lncursesw' \
        ../configure \
        #{CREW_OPTIONS} \
        --disable-nls \
        --enable-64-bit-bfd \
        --enable-host-shared \
        --enable-lto \
        --enable-shared \
        --enable-sim \
        --enable-source-highlight \
        --enable-tui \
        --with-curses \
        --with-lzma \
        --with-pkgversion=Chromebrew \
        --with-python=python3 \
        --with-system-gdbinit=#{CREW_PREFIX}/etc/gdb/gdbinit \
        --with-system-readline \
        --with-system-zlib \
        --with-x"
      system 'make'
    end
  end

  def self.install
    Dir.chdir('build') do
      system "make -C gdb DESTDIR=#{CREW_DEST_DIR} install"
      system "make -C gdbserver DESTDIR=#{CREW_DEST_DIR} install"
    end
    # Remove files conflicting with binutils
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/share/info/bfd.info"
    conflict_packages = %w[binutils]
    conflict_packages.each do |package|
      file = File.read("#{CREW_META_PATH}#{package}.filelist")
      file.each_line do |line|
        if File.exist?("#{CREW_DEST_DIR}#{line}")
          FileUtils.rm_f "#{CREW_DEST_DIR}#{line}"
          puts "Removed #{CREW_DEST_DIR}#{line}"
        end
      end
    end
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libinproctrace.so"
  end
end
