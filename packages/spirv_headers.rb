# Adapted from Arch Linux spirv-headers PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/spirv-headers/trunk/PKGBUILD

require 'package'

class Spirv_headers < Package
  homepage 'https://github.com/KhronosGroup/SPIRV-Headers'
  description 'SPIR-V Headers'
  version '1.3.239.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Headers.git'
  git_hashtag "sdk-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_headers/1.3.239.0_armv7l/spirv_headers-1.3.239.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_headers/1.3.239.0_armv7l/spirv_headers-1.3.239.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_headers/1.3.239.0_i686/spirv_headers-1.3.239.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_headers/1.3.239.0_x86_64/spirv_headers-1.3.239.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6720cd5bf305167e12ad4055ed9ca1c3bf89506ca1ca82c8f3789f1decfd8aa5',
     armv7l: '6720cd5bf305167e12ad4055ed9ca1c3bf89506ca1ca82c8f3789f1decfd8aa5',
       i686: '105ae0fa19df004896b558969432b713cb18e793b75c54fa763a47b76dec1ad9',
     x86_64: '8178f815c883270d734f637e27a1588f7b2115b89398c1d1f4423912dca4cc64'
  })

  def self.build
    system "cmake -B builddir \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS}"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
