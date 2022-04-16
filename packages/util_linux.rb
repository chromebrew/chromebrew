require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.38'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.38/util-linux-2.38.tar.xz'
  source_sha256 '6d111cbe4d55b336db2f1fbeffbc65b89908704c01136371d32aa9bec373eb64'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38_armv7l/util_linux-2.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38_armv7l/util_linux-2.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38_i686/util_linux-2.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38_x86_64/util_linux-2.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bbf94a51e1728672294d33616f81d7047e0e1a95362e7a5b28ddb21e6fa573ad',
     armv7l: 'bbf94a51e1728672294d33616f81d7047e0e1a95362e7a5b28ddb21e6fa573ad',
       i686: '1ae9135cd1ab58f0850c8014fee85aab190cd5f2c5b836f845b1187dcda798f6',
     x86_64: 'c73f881386e26993cac41782c241ed7ef24245bd83117868597aaf23d16c5a77'
  })

  depends_on 'libcap_ng'
  depends_on 'linux_pam'
  depends_on 'pcre2'
  depends_on 'libeconf'
  depends_on 'eudev' if ARCH == 'x86_64' # (for libudev.h)
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
