require 'buildsystems/meson'

class Util_linux < Meson
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
       i686: 'ae3083a9bfdf5d76652fd76100a06003796bdec90ce7c7fe7cdfa42e185bc691',
     x86_64: '15c6bd80d892d59adc0946c401e96cdc4c6c00f48e6859718337803c647cd417'
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
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok

  year2038 = ARCH == 'x86_64' ? '' : '-Dallow-32bit-time=true'
  # Avoid incompatibilities and conflicts with coreutils.
  disabled_builds = ARCH == 'i686' ? '-Dbuild-kill=disabled -Dbuild-blkzone=disabled -Dbuild-lsfd=disabled -Dprogram-tests=false' : '-Dbuild-kill=disabled'
  meson_options "#{year2038} #{disabled_builds}"

  def self.patch
    # Fix undefined reference to `pthread_atfork' build error
    # introduced by https://github.com/util-linux/util-linux/pull/3017
    # and mentioned in https://github.com/util-linux/util-linux/issues/3131 .
    # system "sed -i \"1i thread_dep = dependency('threads')\" libuuid/meson.build"
    # system "sed -i \"s/dependencies : \\\[socket_libs,/dependencies : \\\[socket_libs, thread_dep,/\" libuuid/meson.build"
    patch = [
      # meson: fix a bug in posixipc_libs configuration. See https://github.com/util-linux/util-linux/pull/3532.
      ['https://patch-diff.githubusercontent.com/raw/util-linux/util-linux/pull/3532.patch',
       '4d141fde33dae8c1a469e666161dcb0caea9f6ed18a54257723b07722cf55bf8']
    ]
    ConvenienceFunctions.patch(patch)
  end
end
