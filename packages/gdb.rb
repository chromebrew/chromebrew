# Adapted from Arch Linux gdb PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/gdb/trunk/PKGBUILD

require 'package'

class Gdb < Package
  description 'The GNU Debugger'
  homepage 'https://www.gnu.org/software/gdb/'
  version '12.1-py3.11'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/gdb/gdb-12.1.tar.xz'
  source_sha256 '0e1793bf8f2b54d53f46dea84ccfd446f48f81b297b28c4f7fc017b818d69fed'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-py3.11_armv7l/gdb-12.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-py3.11_armv7l/gdb-12.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-py3.11_i686/gdb-12.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gdb/12.1-py3.11_x86_64/gdb-12.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5d9c9535e1bd99c0eeecbd194738008561e43d48acef7f7050c0bcba892cc181',
     armv7l: '5d9c9535e1bd99c0eeecbd194738008561e43d48acef7f7050c0bcba892cc181',
       i686: '5bdd057f755617dc06a5d06acc201a7a65234c396db046e5c1e6a3d531eca202',
     x86_64: 'e9aee1dec6dd2d353d1a72d3f97fa7dffeee32b54d52e2b8805138798167f54f'
  })

  depends_on 'boost' # R
  depends_on 'elfutils' # R
  depends_on 'expat' # R
  depends_on 'gcc' # R
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
    @readline8patch = <<~'READLINE8_PATCH_EOF'
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
