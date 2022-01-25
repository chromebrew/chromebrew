# Adapted from Arch Linux mimalloc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mimalloc/trunk/PKGBUILD

require 'package'

class Mimalloc < Package
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '2.0.3'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/2.0.3_armv7l/mimalloc-2.0.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/2.0.3_armv7l/mimalloc-2.0.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/2.0.3_i686/mimalloc-2.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mimalloc/2.0.3_x86_64/mimalloc-2.0.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd9c85c5b382e541e381d9377a3b79c21aa7218b61eb737aeb006ec4fb59f1138',
     armv7l: 'd9c85c5b382e541e381d9377a3b79c21aa7218b61eb737aeb006ec4fb59f1138',
       i686: '3116831532dee7c13bccc0e8a8edf20586486ddffb34c301692bb2b7b25deb47',
     x86_64: 'e95daf94c2b590a11b56063375a2b6b92e437dffd737ee726dd11aea3b18af3a'
  })

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
      -DMI_INSTALL_TOPLEVEL=ON \
      -DMI_USE_CXX=ON \
      -DMI_BUILD_TESTS=OFF \
      ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
