# Adapted from Arch Linux cmocka PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cmocka/trunk/PKGBUILD

require 'buildsystems/cmake'

class Cmocka < CMake
  description 'Elegant unit testing framework for C with support for mock objects'
  homepage 'https://cmocka.org/'
  version '1.1.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://cmocka.org/files/1.1/cmocka-1.1.5.tar.xz'
  source_sha256 'f0ccd8242d55e2fd74b16ba518359151f6f8383ff8aef4976e48393f77bba8b6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '377206b2a3535eb15f45878d96d9b100a175de623616b3fcf71e17ab679198c5',
     armv7l: '377206b2a3535eb15f45878d96d9b100a175de623616b3fcf71e17ab679198c5',
       i686: 'f1fa76c44de13364903b2e3cd8a3fd49dde9c20600ff4c810c389118fd4e596e',
     x86_64: 'cf3cc34b349ac21ae5aaaa800b139cb5f22b7a016039ac7af8c78c3224aa0354'
  })

  depends_on 'glibc' # R
  depends_on 'llvm_dev' => :build

  cmake_options '-DUNIT_TESTING=ON'

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-fno-stack-protector/g' CompilerChecks.cmake"
  end
end
