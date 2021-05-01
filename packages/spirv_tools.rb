# Adapted from Arch Linux spirv-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/spirv-tools/trunk/PKGBUILD
require 'package'

class Spirv_tools < Package
  description 'API and commands for processing SPIR-V modules'
  version '2020.7'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools/archive/v2020.7.tar.gz'
  source_sha256 'c06eed1c7a1018b232768481184b5ae4d91d614d7bd7358dc2fe306bd0a39c6e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2020.7_armv7l/spirv_tools-2020.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2020.7_armv7l/spirv_tools-2020.7-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2020.7_i686/spirv_tools-2020.7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2020.7_x86_64/spirv_tools-2020.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '11f7b470632a94066cae7c546fc8a826c2cc34e11aab3544bb1fff64dc3627d4',
     armv7l: '11f7b470632a94066cae7c546fc8a826c2cc34e11aab3544bb1fff64dc3627d4',
       i686: '4a35f21e49c67571334444318560c9f182c1c31d82290927f83330ba7178f3f1',
     x86_64: 'deaebf001fa0d2d78c24b1b7cb6a6b1c062afa88c3c8ae80d79a73db86595597'
  })

  depends_on 'spirv_headers'

  def self.patch
    # Source needs spirv-headers repo as submodule
    @git_dir = 'external/SPIRV-Headers'
    @git_hash = 'f88a1f98fa7a44ccfcf33d810c72b200e7d9a78a'
    @git_url = 'https://github.com/KhronosGroup/SPIRV-Headers'
    FileUtils.rm_rf(@git_dir)
    FileUtils.mkdir_p(@git_dir)
    Dir.chdir @git_dir do
      system 'git init'
      system "git remote add origin #{@git_url}"
      system "git fetch --depth 1 origin #{@git_hash}"
      system 'git checkout FETCH_HEAD'
    end
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DSPIRV_WERROR=Off \
        -DBUILD_SHARED_LIBS=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
