require 'package'

class Vulkan_icd_loader < Package
  description 'Vulkan Installable Client Driver ICD Loader'
  homepage 'https://github.com/KhronosGroup/Vulkan-Loader'
  @_ver = '1.3.230'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Loader.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.230_armv7l/vulkan_icd_loader-1.3.230-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.230_armv7l/vulkan_icd_loader-1.3.230-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.230_i686/vulkan_icd_loader-1.3.230-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_icd_loader/1.3.230_x86_64/vulkan_icd_loader-1.3.230-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '15f8878ef502ebe90ed22535d2e99e6da804e02aae41f0a4c7403c4ae512b26f',
     armv7l: '15f8878ef502ebe90ed22535d2e99e6da804e02aae41f0a4c7403c4ae512b26f',
       i686: 'f36cd322d98a6c6874e9c450cf5bbde693b297cd8315f6e01d7cc94f6ff2d982',
     x86_64: 'fdfb0631b3069712a4aa0095cd0055d5425d842a76bfa5e979fdba04a6a49f7e'
  })

  git_hashtag "v#{@_ver}"

  depends_on 'libx11'
  depends_on 'libxrandr'
  depends_on 'vulkan_headers'
  depends_on 'libx11' => :build
  depends_on 'libxrandr' => :build
  depends_on 'wayland' => :build
  depends_on 'vulkan_headers' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env #{CREW_ENV_OPTIONS} \
        cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DVULKAN_HEADERS_INSTALL_DIR=#{CREW_PREFIX} \
        -DCMAKE_INSTALL_SYSCONFDIR=#{CREW_PREFIX}/etc \
        -DCMAKE_INSTALL_DATADIR=#{CREW_PREFIX}/share \
        -DCMAKE_SKIP_RPATH=True \
        -DBUILD_TESTS=Off \
        -DBUILD_WSI_XCB_SUPPORT=On \
        -DBUILD_WSI_XLIB_SUPPORT=On \
        -DBUILD_WSI_WAYLAND_SUPPORT=On \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
