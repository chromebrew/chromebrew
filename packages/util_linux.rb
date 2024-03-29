require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.40-py3.12'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag '6ff6f5b6ffd9323cc568def2169225dd84bc3a0c'
  # git_hashtag "v#{version[/^.*?(?=-)/]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dce99bef03d7d431d5fa6535f6266c6ed00e1d7fde578116d369e559cab8b3cb',
     armv7l: 'dce99bef03d7d431d5fa6535f6266c6ed00e1d7fde578116d369e559cab8b3cb',
       i686: 'a117bc46b9ead409f5de3070a4a4634b14127b63bc909c3e34362113c02c4140',
     x86_64: '97fa74dc9cb10aaf6818eba7342f69dc34fa144d1add60c433fb20a9eb4962fd'
  })

  depends_on 'bash_completion' # R
  depends_on 'bzip2' # R
  depends_on 'eudev' if ARCH == 'x86_64' # (for libudev.h)
  depends_on 'filecmd' # R
  depends_on 'gcc_lib' # R
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
  lsfd = ARCH == 'i686' ? '-Dbuild-lsfd=disabled' : ''
  # Kill conflicts with coreutils.
  meson_options "-Dbuild-kill=disabled #{year2038} #{lsfd}"

  def self.patch
    return unless ARCH == 'i686'

    # 2.40 needs bpf, which isn't available on i686.
    # See https://github.com/util-linux/util-linux/issues/2874
    downloader 'https://github.com/util-linux/util-linux/pull/2879.patch', '531a8c0904d6b86c0c9adc2a41d657ce1d75cb63e2a408a51cb14fe3d9ffa4dc'
    system 'patch -Np1 -i 2879.patch'
  end
end
