require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version "2.41.3-1-#{CREW_PY_VER}"
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ca17519ba5227b3c81fee800ed2078d79671ee9f10cf6af08580ab6081c177f',
     armv7l: '0ca17519ba5227b3c81fee800ed2078d79671ee9f10cf6af08580ab6081c177f',
       i686: '6ee516c2cace06a6fd13f46376424a01847024979266cfc5fa8cac7f704ad167',
     x86_64: 'e2b44a21ff4c93f2e99496d087a0989fae42eff2da84a020e3f4f4c40d9ab5f8'
  })

  depends_on 'eudev_header' if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'libxcrypt' # R
  depends_on 'linux_pam' # R
  depends_on 'ncurses' # R
  depends_on 'pcre2' => :build
  depends_on 'readline' # R
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sqlite' # R
  depends_on 'zlib' # R

  conflicts_ok

  # Needs to be built with CREW_KERNEL_VERSION=5.10 for the build to
  # succeed on x86_64 and armv7l.
  year2038 = '-Dallow-32bit-time=true'
  i686_disabled_builds = '-Dbuild-blkzone=disabled -Dbuild-lsfd=disabled'
  # Disable python build to avoid circular dependency with python3.
  meson_options "-Dbuild-kill=disabled \
                 -Dbuild-python=disabled \
                 -Dbuild-uuidd=disabled \
                 -Dprogram-tests=false \
                 -Dsystemd=disabled \
                 #{i686_disabled_builds if ARCH == 'i686'} \
                 #{year2038 unless ARCH == 'x86_64'}"
end
