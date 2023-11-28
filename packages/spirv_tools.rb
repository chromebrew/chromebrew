# Adapted from Arch Linux spirv-tools PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/spirv-tools/trunk/PKGBUILD
require 'package'

class Spirv_tools < Package
  homepage 'https://github.com/KhronosGroup/SPIRV-Tools'
  description 'API and commands for processing SPIR-V modules'
  version '2023.1'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/SPIRV-Tools.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2023.1_armv7l/spirv_tools-2023.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2023.1_armv7l/spirv_tools-2023.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2023.1_i686/spirv_tools-2023.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/spirv_tools/2023.1_x86_64/spirv_tools-2023.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '06d70d4c9b44c43fb48f3d413b87469cab743e6046de89259333425f872fb327',
     armv7l: '06d70d4c9b44c43fb48f3d413b87469cab743e6046de89259333425f872fb327',
       i686: '5d6cd3cbbc05608ed3edde1d0d491dbe2ec9fb3a6408103ee6c5e6091e58715e',
     x86_64: '17df444ceba1275d0cfc130aa8ce83ce789aa6d906e2fe7aff94cc54bd6fca8f'
  })

  depends_on 'spirv_headers' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.patch
    # Source needs spirv-headers repo as submodule
    @git_dir = 'external/SPIRV-Headers'
    @git_hash = "sdk-#{Spirv_headers.version}"
    @git_url = 'https://github.com/KhronosGroup/SPIRV-Headers.git'
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
    system "cmake -B builddir \
      -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DSPIRV_WERROR=Off \
      -DBUILD_SHARED_LIBS=ON"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
