# Adapted from Arch Linux crun PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/crun/trunk/PKGBUILD

require 'buildsystems/autotools'

class Crun < Autotools
  description 'A fast and lightweight fully featured OCI runtime and C library for running containers'
  homepage 'https://github.com/containers/crun'
  version '1.28'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/containers/crun.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08a77ac558a26273356753fc9af72fe1f3065a2d36cfe5c23e131357827eccaf',
     armv7l: '08a77ac558a26273356753fc9af72fe1f3065a2d36cfe5c23e131357827eccaf',
     x86_64: '1f0570508295afd42566cc65ac9bf43764003170c72800e93fb6e8d5fa08cb38'
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
