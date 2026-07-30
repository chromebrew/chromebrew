require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version "2.42.2-#{CREW_PY_VER}"
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0907e6cdd3e0547c477963b24ebbdf88077158f474cf13f3fa31a248efa5212',
     armv7l: 'e0907e6cdd3e0547c477963b24ebbdf88077158f474cf13f3fa31a248efa5212',
       i686: 'c5e2397101d529d60e25d99dc68768955ea02df0ee8de3900e3e8bf906b2183a',
     x86_64: 'ab26d552f2a0504f3f1c2a110553163403a20fe146f5a419f62ab7f087bed166'
  })

  depends_on 'eudev_header' => :build if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
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
  # Need -Ddefault_libraru=both to get the static libuuid.a,
  # which is needed by xfsprogs.

  year2038 = '-Dallow-32bit-time=true'
  i686_disabled_builds = '-Dbuild-agetty=disabled -Dbuild-blkzone=disabled -Dbuild-lsfd=disabled'
  meson_options "-Ddefault_library=both \
                 -Dprogram-tests=false \
                 -Dsystemd=disabled \
                 #{i686_disabled_builds if ARCH == 'i686'} \
                 #{year2038 unless ARCH == 'x86_64'}"
end
