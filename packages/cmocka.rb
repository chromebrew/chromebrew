# Adapted from Arch Linux cmocka PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cmocka/trunk/PKGBUILD

require 'buildsystems/cmake'

class Cmocka < CMake
  description 'Elegant unit testing framework for C with support for mock objects'
  homepage 'https://cmocka.org/'
  version '2.0.2'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://cmocka.org/files/#{version.sub(/\.\d+$/, '')}/cmocka-#{version}.tar.xz"
  source_sha256 '39f92f366bdf3f1a02af4da75b4a5c52df6c9f7e736c7d65de13283f9f0ef416'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ac9b9143aa97b13b574bcf2f83f45108cc7ea2e70df5e6bea59b021989a62c1',
     armv7l: '8ac9b9143aa97b13b574bcf2f83f45108cc7ea2e70df5e6bea59b021989a62c1',
     x86_64: 'a987d7182ece6dace474408dcf2ed8e363d342d525668223ed77fce34c01bc20'
  })

  depends_on 'glibc' => :library
  depends_on 'graphviz' => :build
  depends_on 'llvm_dev' => :build

  cmake_options '-DBUILD_TESTING=OFF'
end
