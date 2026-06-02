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
    aarch64: '45c19594c0895b3579c654a02858e40caedc4dac25e186a1739b48ef58048148',
     armv7l: '45c19594c0895b3579c654a02858e40caedc4dac25e186a1739b48ef58048148',
     x86_64: '37b30ed0f3d5ebda5d044e44cd7e901f8315dcb2f59ea9074d49379c3639f132'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libyaml' => :executable
  depends_on 'llvm' => :build
  depends_on 'python3' => :build
  depends_on 'swig' => :build
end
