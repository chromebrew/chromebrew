# Adapted from Arch Linux highway PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/highway/trunk/PKGBUILD

require 'package'

class Highway < Package
  description 'A C++ library for SIMD Single Instruction, Multiple Data'
  homepage 'https://github.com/google/highway/'
  version '1.0.1'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/google/highway/archive/1.0.1/highway-1.0.1.tar.gz'
  source_sha256 '7ca6af7dc2e3e054de9e17b9dfd88609a7fd202812b1c216f43cc41647c97311'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/highway/1.0.1_armv7l/highway-1.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/highway/1.0.1_armv7l/highway-1.0.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/highway/1.0.1_i686/highway-1.0.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/highway/1.0.1_x86_64/highway-1.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ce08cdaa2edb56d438ddadd439dad0aad7cc81b75e79507970355a00d1299d08',
     armv7l: 'ce08cdaa2edb56d438ddadd439dad0aad7cc81b75e79507970355a00d1299d08',
       i686: '5e1a6569a998947c2c93729e27ca62524719ff82e2c37038f589c260d073034b',
     x86_64: 'aa0488630c6ddfbdbecdd43870568767f4bb99075f188285d4fb9d5af2caa6dd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "mold -run cmake \
          #{CREW_CMAKE_OPTIONS} \
          -DBUILD_SHARED_LIBS:BOOL='ON' \
          -DHWY_ENABLE_TESTS:BOOL='OFF' \
          -DHWY_SYSTEM_GTEST:BOOL='OFF' \
          -Wdev \
          -G Ninja \
          .."
      system 'mold -run samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
