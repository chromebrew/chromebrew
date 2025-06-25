require 'buildsystems/autotools'

class Util_linux < Autotools
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version "2.41.1-#{CREW_PY_VER}"
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db53c6aac00a7b8538b21779e2540ab523f837493aff0548f39469e92a899d08',
     armv7l: 'db53c6aac00a7b8538b21779e2540ab523f837493aff0548f39469e92a899d08',
       i686: 'ef3547c60f160f7bfb1e3a8acce8f21838bc33dd371215bf71efc5f5978d5d4c',
     x86_64: '7d831a53ebdc3a9c114293584c0a900a626aeb7f83aaefe1379e3bb550ebc3bc'
  })

  depends_on 'bzip2' # R
  depends_on 'eudev' if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'libxcrypt' # R
  depends_on 'linux_pam' # R
  depends_on 'lzlib' # R
  depends_on 'ncurses' # R
  depends_on 'pcre2' => :build
  depends_on 'readline' # R
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sqlite' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok

  year2038 = '--disable-year2038'
  i686_disabled_builds = '--disable-blkzone --disable-lsfd'
  autotools_configure_options "#{year2038 unless ARCH == 'x86_64'} \
                              --disable-kill \
                              #{i686_disabled_builds if ARCH == 'i686'} \
                              --disable-makeinstall-chown \
                              --disable-makeinstall-setuid \
                              --disable-makeinstall-tty-setgid \
                              --without-systemd \
                              --without-udev"
end
