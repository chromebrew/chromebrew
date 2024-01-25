require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.39.3-py3.12'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/util-linux-2.39.3.tar.xz'
  source_sha256 '7b6605e48d1a49f43cc4b4cfc59f313d0dd5402fa40b96810bd572e167dfed0f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b5e262a746e45839e15095615d46ca019ec1c1aa8d5dd25b50a02f15ac34441f',
     armv7l: 'b5e262a746e45839e15095615d46ca019ec1c1aa8d5dd25b50a02f15ac34441f',
       i686: '082eca25c5a7c714bdfbb906952ecf948458ce1a93edc47a140b6ca9024e4304',
     x86_64: '23c2ea99c198e5bc5af485b4f090f1257355df07a2e5f32858250c45b7af76e3'
  })

  depends_on 'bzip2' # R
  depends_on 'eudev' if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' # R
  depends_on 'glibc' # R
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'linux_pam' # R
  depends_on 'lzlib' # R
  depends_on 'ncurses' # R
  depends_on 'pcre2' => :build
  depends_on 'readline' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  no_env_options

  def self.patch
    # Fix sys-utils/setarch.c:90:7: error: PER_LINUX_FDPIC undeclared here
    system "sed -i 's,PER_LINUX_FDPIC,PER_LINUX_32BIT,' sys-utils/setarch.c" if ARCH == 'i686'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --with-python=3 \
      --enable-fs-paths-extra=#{CREW_PREFIX}/sbin \
      --without-systemd \
      --with-econf \
      --with-ncursesw \
      --without-cryptsetup"
    system "sed -i -e '/chgrp/d' -e '/chown/d' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # conflict with coreutils
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/man/man1/kill.1"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/kill"
  end
end
