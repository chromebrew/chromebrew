# Adapted from Arch Linux mimalloc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mimalloc/trunk/PKGBUILD

require 'package'

class Mimalloc < Package
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  git_hashtag '221f96ac2c999ef22414521fb39438018dfa9a41'
  @_ver = (@git_hashtag[0, 6])
  version "dev-slice-#{@_ver}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_branch 'dev-slice'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/dev-slice-221f96_armv7l/mimalloc-dev-slice-221f96-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/dev-slice-221f96_armv7l/mimalloc-dev-slice-221f96-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/dev-slice-221f96_i686/mimalloc-dev-slice-221f96-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/dev-slice-221f96_x86_64/mimalloc-dev-slice-221f96-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '49cd61a1b29a78db7127702148eff3b5bcb92fbeef193cafda628b023dd70fad',
     armv7l: '49cd61a1b29a78db7127702148eff3b5bcb92fbeef193cafda628b023dd70fad',
       i686: '7c0ac47c0d298f2d7e4ec4dfd2a2f22e706c8d9165f49a3c955006272e8f7691',
     x86_64: '6fc9e9e7eb75c6b0bf794e321b7f2a9a48cc228c398512abbef5c8562c7bd7ec'
  })

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DMI_INSTALL_TOPLEVEL=ON \
      -DMI_USE_CXX=ON \
      -DMI_BUILD_TESTS=OFF \
      -DMI_OVERRIDE=ON \
      -Wno-dev \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
