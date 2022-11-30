require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.38.1'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.38/util-linux-2.38.1.tar.xz'
  source_sha256 '60492a19b44e6cf9a3ddff68325b333b8b52b6c59ce3ebd6a0ecaa4c5117e84f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38.1_armv7l/util_linux-2.38.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38.1_armv7l/util_linux-2.38.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38.1_i686/util_linux-2.38.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.38.1_x86_64/util_linux-2.38.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '43eb0bf0f2f25a6de16b6da2117488a2af3271f19a4f2eb8cbb3d24a35c98b14',
     armv7l: '43eb0bf0f2f25a6de16b6da2117488a2af3271f19a4f2eb8cbb3d24a35c98b14',
       i686: '7cf66b87e3d4441096fed54c8a4b5b9414eb49530bb1938af07757fac3baae02',
     x86_64: 'ffbdb18c1d22d32605c2a8033f795ee97dc8a0adaf7a1f4e6c83a810c36becfe'
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
