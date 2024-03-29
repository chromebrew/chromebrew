require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  case ARCH
  when 'i686'
    # 2.40 needs bpf, which isn't available on i686.
    # See https://github.com/util-linux/util-linux/issues/2874
    version '2.39.3-py3.12'
  else
    version '2.40-py3.12'
  end
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version[/^.*?(?=-)/]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df71ebcfffc64a80e2fb2956c8a834f7da22393ddafd1f12425952d5a66e0675',
     armv7l: 'df71ebcfffc64a80e2fb2956c8a834f7da22393ddafd1f12425952d5a66e0675',
       i686: '082eca25c5a7c714bdfbb906952ecf948458ce1a93edc47a140b6ca9024e4304',
     x86_64: '23ee3e2a1d1d702a1b3b0e65a22fd0e7589825dc77585e4c3a6006193df9976e'
  })

  depends_on 'bash_completion' # R
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
  depends_on 'ruby_asciidoctor' => :build
  depends_on 'sqlite' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  year2038 = ARCH == 'x86_64' ? '' : '-Dallow-32bit-time=true'

  # Kill conflicts with coreutils.
  meson_options "-Dbuild-kill=disabled #{year2038}"
end
