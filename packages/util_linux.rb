require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.39.1-py3.11'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/util-linux-2.39.1.tar.xz'
  source_sha256 '890ae8ff810247bd19e274df76e8371d202cda01ad277681b0ea88eeaa00286b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.1_armv7l/util_linux-2.39.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.1_armv7l/util_linux-2.39.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.1_i686/util_linux-2.39.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.1_x86_64/util_linux-2.39.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4ce6e57e3f5fab54f18764edc9edfd059faf94b45b8e43930aa5f6f879761794',
     armv7l: '4ce6e57e3f5fab54f18764edc9edfd059faf94b45b8e43930aa5f6f879761794',
       i686: '9b84a3f15cfa13ef60ae498d0cf9cf1d1ca04bef988da28973367a7b313104f8',
     x86_64: 'eae35dd81597ed8506bec34aaa7b5050c26e55325110ca4b0567299896f623eb'
  })

  depends_on 'bz2' # R
  depends_on 'eudev' if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' # R
  depends_on 'glibc' # R
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'linux_pam' # R
  depends_on 'ncurses' # R
  depends_on 'pcre2' => :build
  depends_on 'readline' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  patchelf
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
