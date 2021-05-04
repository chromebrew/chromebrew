# Adapted from Arch Linux shaderc PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/shaderc/trunk/PKGBUILD

require 'package'

class Shaderc < Package
  description 'Collection of tools, libraries and tests for shader compilation'
  version '2020.5'
  license 'Apache'
  compatibility 'all'
  source_url "https://github.com/google/shaderc/archive/refs/tags/v#{version}.tar.gz"
  source_sha256 'e96d8cb208b796cecb9e6cce437c7d1116343158ef3ea26277eb13b62cf56834'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2020.5_armv7l/shaderc-2020.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2020.5_armv7l/shaderc-2020.5-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2020.5_i686/shaderc-2020.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shaderc/2020.5_x86_64/shaderc-2020.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '74e0264a8277b173f33e04e84a31a118173c2f4c5013ddd9f68f51a4a38b0965',
     armv7l: '74e0264a8277b173f33e04e84a31a118173c2f4c5013ddd9f68f51a4a38b0965',
       i686: '061996cc65ec0c60bd26a09b26e5d949504d2c6718eae3531949b4ccf9d2da3f',
     x86_64: '9e32e0db031138d5ead88e9e6a99f1a14d1d07e6c89999f0d336d105462b1306'
  })

  depends_on 'asciidoctor' => :build

  def self.build
    system './utils/git-sync-deps'
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
        -DSHADERC_SKIP_TESTS=ON \
        -DSHADERC_ENABLE_EXAMPLES=OFF \
        -DCMAKE_CXX_FLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
