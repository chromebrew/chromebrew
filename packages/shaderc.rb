# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'package'

class Shaderc < Package
  description 'Collection of tools, libraries and tests for shader compilation'
  version '2023.2'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.2_armv7l/shaderc-2023.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.2_armv7l/shaderc-2023.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.2_i686/shaderc-2023.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.2_x86_64/shaderc-2023.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '82dae8a8ea92e6ddeee954db3ed57c61dc8f6fbd5cad222e1a1a656525b85be0',
     armv7l: '82dae8a8ea92e6ddeee954db3ed57c61dc8f6fbd5cad222e1a1a656525b85be0',
       i686: '894583bffe1d861a0bb56b9a7f7ad04769d296b7e4433abe404c6661359b0129',
     x86_64: '35cb29eb703b562c83a749d9427c10e80a47cc734ade0d233f1163ac6b5c9fff'
  })

  depends_on 'ruby_asciidoctor' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system './utils/git-sync-deps'
    system "cmake -B builddir -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DSPIRV_WERROR=Off \
        -DBUILD_SHARED_LIBS=ON \
        -DSHADERC_SKIP_TESTS=ON \
        -DSHADERC_ENABLE_EXAMPLES=OFF \
        -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
