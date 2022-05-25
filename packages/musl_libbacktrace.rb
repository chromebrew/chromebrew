# Adapted from Arch Linux libbacktrace-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libbacktrace-git

require 'package'

class Musl_libbacktrace < Package
  description 'Library to produce symbolic backtraces'
  homepage 'https://github.com/ianlancetaylor/libbacktrace'
  version 'd0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a'
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'https://github.com/ianlancetaylor/libbacktrace.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_armv7l/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_armv7l/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_i686/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_x86_64/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6bbc858bbdaad878e275581442c17cae435cf936fec7bf1d98da24b93f46c729',
     armv7l: '6bbc858bbdaad878e275581442c17cae435cf936fec7bf1d98da24b93f46c729',
       i686: 'b2a40ba11af574e0a39cb2f3ec7e3befcc6640d44b474c4b04a558f1303a225d',
     x86_64: '675283778411fed85ce6890f2bdce2d6e4f8b0956f8c1c3d2eb93c80ecc7e381'
  })

  depends_on 'musl_native_toolchain' => :build

  def self.build
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system "./configure --prefix=#{CREW_MUSL_PREFIX} \
      #{MUSL_ENV_OPTIONS} \
      --enable-shared \
      --enable-static"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
