require 'buildsystems/meson'

class Dtc < Meson
  description 'Device Tree Compiler'
  homepage 'https://www.devicetree.org/'
  version '1.8.1'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.kernel.org/pub/software/utils/dtc/dtc-#{version}.tar.xz"
  source_sha256 '23526015a6f1550e0541a53fe7acea1b5a11e3697cdf3a3bdc076abc38f6045d'
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
end
