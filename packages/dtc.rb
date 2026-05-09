# Adapted from Arch Linux dtc PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/dtc/trunk/PKGBUILD

require 'package'

class Dtc < Package
  description 'Device Tree Compiler'
  homepage 'https://www.devicetree.org/'
  version '1.7.2'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.kernel.org/pub/software/utils/dtc/dtc-#{version}.tar.xz"
  source_sha256 '92d8ca769805ae1f176204230438fe52808f4e1c7944053c9eec0e649b237539'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50e0fe9efd29bb4339a93184d8b442c87f8dc1230322ede40aeb905ea0ff50c1',
     armv7l: '50e0fe9efd29bb4339a93184d8b442c87f8dc1230322ede40aeb905ea0ff50c1',
     x86_64: 'e8a6cdabba4ab7f04aecac8d6e41cfcd59e6d54dac50be84a664363429ead978'
  })

  depends_on 'glibc' => :library
  depends_on 'libyaml' => :executable
  depends_on 'llvm' => :build
  depends_on 'python3' => :build
  depends_on 'swig' => :build

  def self.build
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make \
      PREFIX=#{CREW_DEST_PREFIX} \
      SETUP_PREFIX=#{CREW_DEST_PREFIX} \
      LIBDIR=#{CREW_DEST_LIB_PREFIX} install"
  end
end
