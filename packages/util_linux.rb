require 'buildsystems/meson'

class Util_linux < Meson
  description 'essential linux tools'
  homepage 'https://www.kernel.org/pub/linux/utils/util-linux/'
  version '2.40-py3.12'
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
  # Needs bpf, which isn't available on i686.
  lsfd = ARCH == 'i686' ? '-Dbuild-lsfd=disabled' : ''
  # Kill conflicts with coreutils.
  meson_options "-Dbuild-kill=disabled #{year2038} #{lsfd}"

  def self.patch
    File.write 'lsfd.patch', <<~LSFD_PATCHEOF
      diff -Npaur a/meson.build b/meson.build
      --- a/meson.build	2024-03-28 23:37:49.623330230 -0400
      +++ b/meson.build	2024-03-28 23:39:08.982615866 -0400
      @@ -2703,6 +2703,7 @@ endif
       mq_libs = []
       mq_libs += cc.find_library('rt', required : true)

      +opt = not get_option('build-lsfd').disabled()
       exe = executable(
         'lsfd',
         lsfd_sources,
      @@ -2712,7 +2713,7 @@ exe = executable(
         dependencies : mq_libs,
         install_dir : usrbin_exec_dir,
         install : true)
      -if not is_disabler(exe)
      +if opt and not is_disabler(exe)
         exes += exe
         manadocs += ['misc-utils/lsfd.1.adoc']
       endif
      diff -Npaur a/meson_options.txt b/meson_options.txt
      --- a/meson_options.txt	2024-03-28 23:39:28.782438124 -0400
      +++ b/meson_options.txt	2024-03-28 23:40:38.789810977 -0400
      @@ -53,6 +53,8 @@ option('build-fdisks', type : 'feature',
              description : 'build fdisk(8), sfdisk(8) and cfdisk(8)')
       option('build-mount', type : 'feature',
              description : 'build mount(8) and umount(8)')
      +option('build-lsfd', type : 'feature',
      +       description : 'build lsfd')
       option('build-losetup', type : 'feature',
              description : 'build losetup')
       option('build-zramctl', type : 'feature',
    LSFD_PATCHEOF
    system 'patch -Np1 -i lsfd.patch'
  end
end
