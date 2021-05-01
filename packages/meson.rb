require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  @_ver = '0.57.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/mesonbuild/meson/archive/#{@_ver}.tar.gz"
  source_sha256 'cd3773625253df4fd1c380faf03ffae3d02198d6301e7c8bc7bba6c66af66096'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.57.2_armv7l/meson-0.57.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.57.2_armv7l/meson-0.57.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.57.2_i686/meson-0.57.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.57.2_x86_64/meson-0.57.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '159a2101c1ca6a798baeeee0b95cd10950d7b62e088fa0229270b11983c27ec0',
     armv7l: '159a2101c1ca6a798baeeee0b95cd10950d7b62e088fa0229270b11983c27ec0',
       i686: 'f8a173fefc3b188208fbd6da61f3f9b0e94db62b8bbdb18573b8d740547ade82',
     x86_64: '4f6668f8cf6463fbe20e9d7de20d818548ab53ec69c7dae1e5700f57e6d6b816'
  })

  depends_on 'ninja'
  depends_on 'samurai'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
