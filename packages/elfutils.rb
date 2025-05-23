require 'buildsystems/autotools'

class Elfutils < Autotools
  description 'elfutils is a collection of utilities and libraries to read, create and modify ELF binary files, find and handle DWARF debug data, symbols, thread state and stacktraces for processes and core files on GNU/Linux.'
  homepage 'https://sourceware.org/elfutils/'
  version '0.192'
  license 'GPL-2+ or LGPL-3+'
  compatibility 'all'
  source_url 'https://sourceware.org/git/elfutils.git'
  git_hashtag "elfutils-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'abf24a50af269b1c68cdd5a744ae76c36a064668d28baa5bad3b3d5f69af5a48',
     armv7l: 'abf24a50af269b1c68cdd5a744ae76c36a064668d28baa5bad3b3d5f69af5a48',
       i686: '11df8c8616d54f2a78bd1eee6d468ffc9cf87269aaa853fa628b1bd7e5254be6',
     x86_64: '7ae043365539b0b193166b1695cebc49de05d6841f6e8787430826034eb0fb19'
  })

  depends_on 'bzip2' # R
  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libarchive' # R
  depends_on 'libmicrohttpd' # R
  depends_on 'sqlite' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  # -D_FORTIFY_SOURCE=0 needed due to -O3 optimization.
  autotools_pre_configure_options "CFLAGS+=' -Wno-error -D_FORTIFY_SOURCE=0' CXXFLAGS+=' -Wno-error -D_FORTIFY_SOURCE=0'"
  autotools_configure_options "#{ARCH == 'i686' ? '--disable-libdebuginfod --disable-debuginfod' : ''} --enable-maintainer-mode --program-prefix='eu-'"

  def self.patch
    downloader 'https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/main/package/libs/elfutils/patches/009-fix-null-dereference-with-lto.patch', 'bd81d483ed5474fd7e87a27e4c961bf8670f76c45f5fe9a273cb2f11d8f44ffc'
    system 'patch -Np1 -i 009-fix-null-dereference-with-lto.patch'
    downloader 'https://raw.githubusercontent.com/openwrt/openwrt/refs/heads/main/package/libs/elfutils/patches/102-fix-potential-deref-of-null-error.patch', '4be7368570bf64d38d34ae8147946e0d3741103e3b4dd0000d4e5c228d16e352'
    system 'patch -Np1 -i 102-fix-potential-deref-of-null-error.patch'

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
