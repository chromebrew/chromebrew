# Adapted from Arch Linux crun PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/crun/trunk/PKGBUILD

require 'buildsystems/autotools'

class Crun < Autotools
  description 'A fast and lightweight fully featured OCI runtime and C library for running containers'
  homepage 'https://github.com/containers/crun'
  version '1.30.1'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/crun.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27d64979807ac181a0838f04c5e7ca6458141fa798d84dcbb59eb8d9d6d92234',
     armv7l: '27d64979807ac181a0838f04c5e7ca6458141fa798d84dcbb59eb8d9d6d92234',
     x86_64: 'c3f0145696519cdc2f1824d22a3ac0123aabc1c7a1ba87e968019aff1381a89b'
  })

  depends_on 'criu' if ARCH.eql?('x86_64')
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'go_md2man' => :build
  depends_on 'json_c' => :library
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

  def self.patch
    patches = [
      # Fix for json_c link error.
      ['https://github.com/containers/crun/pull/2102.diff', '1bd303ce60efd77ef20927a1fbfa65e2cab84a41f9e927f2ad1e3f47c7d85a8f']
    ]
    ConvenienceFunctions.patch(patches) if version == '1.28'
  end
end
