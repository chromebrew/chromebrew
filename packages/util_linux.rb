require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version "2.41.2-9179172-#{CREW_PY_VER}"
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  # Build from stable/v2.4.1 branch.
  git_hashtag '917917253e60b0ba485cf6a27a2f993aa43e1eea'
  # git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '91decac55f4df9b732374862399db44b9104b60dfc0a538f5686886d1d83ac30',
     armv7l: '91decac55f4df9b732374862399db44b9104b60dfc0a538f5686886d1d83ac30',
       i686: '0b5c219fa26fe65437b9261bef0f178763595cbf5d1346d65e3d15d7fff2a089',
     x86_64: '3e109b0a94fe9369382ac1cda73225f842ec06d00086a0a1019f6f4738f184fc'
  })

  depends_on 'eudev' if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libcap_ng' # R
  depends_on 'libeconf' # R
  depends_on 'libxcrypt' # R
  depends_on 'linux_pam' # R
  depends_on 'ncurses' # R
  depends_on 'pcre2' => :build
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sqlite' # R
  depends_on 'zlib' # R

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
