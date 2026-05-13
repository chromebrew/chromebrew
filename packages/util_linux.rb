require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version "2.42-1-#{CREW_PY_VER}"
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c90a874b1f9b365c69a9d29286d6e8461971e19eda2572b9572f67e44a01f664',
     armv7l: 'c90a874b1f9b365c69a9d29286d6e8461971e19eda2572b9572f67e44a01f664',
       i686: '529ae5ff5efbaf728fc90b0347ee350c9af1f2f17ef3d5abf5d9f4fcc31e23d8',
     x86_64: '3ee8d4b3acf237c771fda73255b614423f57970feb833ab80ac8c8958cd08c71'
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
  # Need -Ddefault_libraru=both to get the static libuuid.a,
  # which is needed by xfsprogs.
  year2038 = '-Dallow-32bit-time=true'
  i686_disabled_builds = '-Dbuild-blkzone=disabled -Dbuild-lsfd=disabled'
  meson_options "-Ddefault_library=both \
                 -Dbuild-kill=disabled \
                 -Dbuild-uuidd=disabled \
                 -Dprogram-tests=false \
                 -Dsystemd=disabled \
                 #{i686_disabled_builds if ARCH == 'i686'} \
                 #{year2038 unless ARCH == 'x86_64'}"
end
