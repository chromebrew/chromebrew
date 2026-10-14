# Adapted from Arch Linux libabigail PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libabigail

require 'buildsystems/autotools'

class Libabigail < Autotools
  description 'ABI Generic Analysis and Instrumentation Library'
  homepage 'https://sourceware.org/libabigail/'
  version "3.0-#{CREW_PY_VER}"
  license 'Apache'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://sourceware.org/git/libabigail.git'
  git_hashtag "libabigail-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '417416e37d9e13cb248dac25347c86ca388499592de7df4b5a2cb2444c4d81d0',
     armv7l: '417416e37d9e13cb248dac25347c86ca388499592de7df4b5a2cb2444c4d81d0',
     x86_64: 'bebbda2de8b966e1ea6b9a7dcf4e96958815770c3459cf4684013d5419a3e959'
  })

  depends_on 'binutils' => :library
  depends_on 'elfutils' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdb' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxml2' => :library
  depends_on 'python3' => :build
  depends_on 'sphinx' => :build
  depends_on 'xxhash' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--enable-bash-completion \
    --disable-manual \
    --disable-apidoc \
    --disable-static'
end
