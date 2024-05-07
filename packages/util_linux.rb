require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.40.1-py3.12'
  license 'GPL-2, LGPL-2.1, BSD-4, MIT and public-domain'
  compatibility 'all'
  source_url 'https://github.com/util-linux/util-linux.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4dd547d28140af6fd9e891787e146fe073122c617b32f2cfe89c9fb47b4b8e8',
     armv7l: 'b4dd547d28140af6fd9e891787e146fe073122c617b32f2cfe89c9fb47b4b8e8',
       i686: '658cf6859fc4cddf46e95451be4d77ae09cea0c7aa8ed89b80106abe9132ef64',
     x86_64: '4af0730dfa0f8b458f44a0cb1831df26bc75d49a1031c89cc521ddd0c1b7eeda'
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
  # Avoid incompatibilities and conflicts with coreutils.
  disabled_builds = ARCH == 'i686' ? '-Dbuild-kill=disabled -Dbuild-blkzone=disabled -Dbuild-lsfd=disabled -Dprogram-tests=false' : '-Dbuild-kill=disabled'
  meson_options "#{year2038} #{disabled_builds}"
end
