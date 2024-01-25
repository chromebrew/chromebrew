# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'package'

class Shaderc < Package
  description 'Collection of tools, libraries and tests for shader compilation'
  homepage 'https://github.com/google/shaderc'
  version '2023.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/google/shaderc.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.8_armv7l/shaderc-2023.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.8_armv7l/shaderc-2023.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.8_i686/shaderc-2023.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2023.8_x86_64/shaderc-2023.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0c21288bcfcc9f477a938a4a3a33c1bc9c8b44d473363547cce3dd6af5d91714',
     armv7l: '0c21288bcfcc9f477a938a4a3a33c1bc9c8b44d473363547cce3dd6af5d91714',
       i686: 'd0b7a92f5021b97f5c9e0ec229acae6f2820b8b38a037755c526328458442c7c',
     x86_64: '981a43dee48b92467c019941b665c6f5844e86c1b7b6ef81e11bbc345683ac10'
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
