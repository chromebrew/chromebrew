require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version "2.42-#{CREW_PY_VER}"
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fc647511249286521d9123e96e534c3020d682f56fe3f27cb47798750e572bd',
     armv7l: '0fc647511249286521d9123e96e534c3020d682f56fe3f27cb47798750e572bd',
       i686: '994d79450826fc892e094b9d50e6a0f5d8d2a3f6fcad30e04aa61b87495ecfb0',
     x86_64: 'd5f9ee0e33ed5b6613115d979f390bc7926941fa4ea15b6b1cc1a3e2efdfb159'
  })

  depends_on 'eudev_header' => :build if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'libcap_ng' => :executable
  depends_on 'libeconf' => :library
  depends_on 'libxcrypt' => :executable
  depends_on 'linux_pam' => :library
  depends_on 'ncurses' => :executable
  depends_on 'pcre2' => :build
  depends_on 'readline' => :executable
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sqlite' => :library
  depends_on 'zlib' => :executable

  conflicts_ok

  # Needs to be built with CREW_KERNEL_VERSION=5.10 for the build to
  # succeed on x86_64 and armv7l.
  year2038 = '-Dallow-32bit-time=true'
  i686_disabled_builds = '-Dbuild-blkzone=disabled -Dbuild-lsfd=disabled'
  meson_options "-Dbuild-kill=disabled \
                 -Dbuild-uuidd=disabled \
                 -Dprogram-tests=false \
                 -Dsystemd=disabled \
                 #{i686_disabled_builds if ARCH == 'i686'} \
                 #{year2038 unless ARCH == 'x86_64'}"
end
