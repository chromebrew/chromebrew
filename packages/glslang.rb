# Adapted from Arch Linux glslang PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/glslang/trunk/PKGBUILD

require 'package'

class Glslang < Package
  description 'OpenGL and OpenGL ES shader front end and validator'
  homepage 'https://github.com/KhronosGroup/glslang'
  version '12.1.0'
  license 'BSD-3, MIT, BSD-2, Apache-2.0 and NVIDIA'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/glslang.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.1.0_armv7l/glslang-12.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.1.0_armv7l/glslang-12.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.1.0_i686/glslang-12.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glslang/12.1.0_x86_64/glslang-12.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4128dbcc3f8258307d0050fa326d5d0de27bacf578127efc16eda3a543b37014',
     armv7l: '4128dbcc3f8258307d0050fa326d5d0de27bacf578127efc16eda3a543b37014',
       i686: '7d3ce7f031d4865ba73b0a10d32ed8de1e24ec283e22583310580d03c71e5ea1',
     x86_64: 'd6302ef78d844eedb20e950f17be4fcdc1d80c080ce742e2e60de22d2d1989df'
  })

  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' => :build
  depends_on 'gcc' # R
  depends_on 'glibc' # R

  def self.build
    system "cmake -B build \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
