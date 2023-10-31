require 'package'

class Util_linux < Package
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.39.2-py3.12'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.39/util-linux-2.39.2.tar.xz'
  source_sha256 '87abdfaa8e490f8be6dde976f7c80b9b5ff9f301e1b67e3899e1f05a59a1531f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.2-py3.12_armv7l/util_linux-2.39.2-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.2-py3.12_armv7l/util_linux-2.39.2-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.2-py3.12_i686/util_linux-2.39.2-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/util_linux/2.39.2-py3.12_x86_64/util_linux-2.39.2-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '35acf85706ecc5fdc3fefcf165042d880a9b8c7a0a4e81eae205ce922c28d30e',
     armv7l: '35acf85706ecc5fdc3fefcf165042d880a9b8c7a0a4e81eae205ce922c28d30e',
       i686: '191eb6130e80862c29f56eb8834cc07a962156445cc920f298e96c7e3176aaff',
     x86_64: '3b6d221adae7b6533e3f586e28ecabc4d7fee6472e220b190a87b8c623961d75'
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
