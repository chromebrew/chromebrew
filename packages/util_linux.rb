require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version "2.42.2-1-#{CREW_PY_VER}"
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5fdbc4600ad11521d821e9798feb7534e1ad8ca152f1d4897de1b5c6ca66a6e1',
     armv7l: '5fdbc4600ad11521d821e9798feb7534e1ad8ca152f1d4897de1b5c6ca66a6e1',
       i686: '9da8fd884ce7febd54797ac4e454aa5bf243f7d7d3d777253730acdced8bfccf',
     x86_64: 'd36014eb17d0f094a572b106054b108b66a33e29827ad4b97cbff387a2f83d72'
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
  # Need -Ddefault_library=both to get the static libuuid.a,
  # which is needed by xfsprogs.

  year2038 = '-Dallow-32bit-time=true'
  i686_disabled_builds = '-Dbuild-agetty=disabled -Dbuild-blkzone=disabled -Dbuild-lsfd=disabled'
  meson_options "-Ddefault_library=both \
                 -Dprogram-tests=false \
                 -Dsystemd=disabled \
                 #{i686_disabled_builds if ARCH == 'i686'} \
                 #{year2038 unless ARCH == 'x86_64'}"
end
