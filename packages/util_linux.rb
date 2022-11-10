require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.38-1'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.38/util-linux-2.38.tar.xz'
  source_sha256 '6d111cbe4d55b336db2f1fbeffbc65b89908704c01136371d32aa9bec373eb64'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38-1_armv7l/util_linux-2.38-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38-1_armv7l/util_linux-2.38-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38-1_i686/util_linux-2.38-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38-1_x86_64/util_linux-2.38-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b8492be34581baf8ffec9de99bfcc00a95d3bc6f351ccefe77efe9b7556fe8cf',
     armv7l: 'b8492be34581baf8ffec9de99bfcc00a95d3bc6f351ccefe77efe9b7556fe8cf',
       i686: '711b11686f6f9a907bc495d8f453bf7e733ee07cb7db874e2fe7c80ed566a66b',
     x86_64: 'c1f896ebee89f3155b8f4d4422b4bd9d9c16be77cac8587e86b3e3ab14f7fe8a'
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
