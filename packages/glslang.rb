# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'package'

class Glslang < Package
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '12.0.0'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.0.0_armv7l/glslang-12.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.0.0_armv7l/glslang-12.0.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.0.0_i686/glslang-12.0.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.0.0_x86_64/glslang-12.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'faf914601e515f39d2ef854e427cea8a75fa70aa3d0fa9ebd70a6d9ee21c13f8',
     armv7l: 'faf914601e515f39d2ef854e427cea8a75fa70aa3d0fa9ebd70a6d9ee21c13f8',
       i686: 'a0e1b631baa510e7d7baeda275bade2b4518a9c31273c156dbdc7cd837c5e5b6',
     x86_64: '2247c659389a1b6b31d95f365addb9267cfcacae5f69af321945ceeea4d300ae'
  })

  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R

  def self.build
    system "cmake -B build-static \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DBUILD_SHARED_LIBS=OFF"
    system 'ninja -C build-static'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build-static install"
  end
end
