require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.3.240'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.240_armv7l/vulkan_headers-1.3.240-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.240_armv7l/vulkan_headers-1.3.240-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.240_i686/vulkan_headers-1.3.240-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.240_x86_64/vulkan_headers-1.3.240-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e9d8e8462372341d053a1cff4750449abc594b344f382101af2a65834e02235b',
     armv7l: 'e9d8e8462372341d053a1cff4750449abc594b344f382101af2a65834e02235b',
       i686: 'aceec0f02f2da30a3a0d64ccf747b2d94e745029accb1f93698c067171f21cdd',
     x86_64: 'a56eeecc0442fc11dfa6b499c0efe9dd3acfe0b10c49af1f1354d1fac5e2ccf9'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
