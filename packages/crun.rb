# Adapted from Arch Linux crun PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/crun/trunk/PKGBUILD

require 'buildsystems/autotools'

class Crun < Autotools
  description 'A fast and lightweight fully featured OCI runtime and C library for running containers'
  homepage 'https://github.com/containers/crun'
  version '1.27.1'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/crun.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1aef817d9cfcc6b170260b55887f7c6bc723460585036e40a55fd4d386a04da',
     armv7l: 'c1aef817d9cfcc6b170260b55887f7c6bc723460585036e40a55fd4d386a04da',
     x86_64: '7239e82f6029e60e71e7207d94b94d985fc954fcbc04b400c8ee6d8397731aa3'
  })

  depends_on 'criu' if ARCH.eql?('x86_64')
  depends_on 'glibc' => :library
  depends_on 'go_md2man' => :build
  depends_on 'libbpf' => :build
  depends_on 'libcap' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libgpg_error' => :library
  depends_on 'libseccomp' => :library
  depends_on 'yajl' => :library

  autotools_configure_options "#{'--disable-criu' unless ARCH.eql?('x86_64')} \
    --disable-systemd \
    --enable-shared \
    --enable-dynamic \
    --with-python-bindings"
end
