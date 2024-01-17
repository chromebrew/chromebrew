# Adapted from Arch Linux spirv-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/spirv-tools/trunk/PKGBUILD
require 'package'

class Spirv_tools < Package
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2023.6.rc1'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2023.6.rc1_armv7l/spirv_tools-2023.6.rc1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2023.6.rc1_armv7l/spirv_tools-2023.6.rc1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2023.6.rc1_x86_64/spirv_tools-2023.6.rc1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd925a80ea99206946477c5c6223629c06bbad55981da677e2ab54bbee23d843b',
     armv7l: 'd925a80ea99206946477c5c6223629c06bbad55981da677e2ab54bbee23d843b',
     x86_64: '26a772a1baadd956f875e2c9db1e371b068caf8e4546e7884965294882603974'
  })

  depends_on 'spirv_headers' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  git_fetchtags
  no_lto

  def self.build
    system 'utils/git-sync-deps'
    system "cmake -B builddir \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DSPIRV_WERROR=Off \
      -DSPIRV_TOOLS_BUILD_STATIC=OFF \
      -DSPIRV_SKIP_TESTS=ON \
      -DBUILD_SHARED_LIBS=ON"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
