# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.6.0'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold/archive/v1.6.0.tar.gz'
  source_sha256 '59cd3ea1a2a5fb50d0d97faddd8bff4c7e71054a576c00a87b17f56ecbd88729'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.6.0_armv7l/mold-1.6.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.6.0_armv7l/mold-1.6.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.6.0_i686/mold-1.6.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.6.0_x86_64/mold-1.6.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '55209367a91c88244cb88fdd514a80c6acbece5e5a649915c1f65874b0e4a60c',
     armv7l: '55209367a91c88244cb88fdd514a80c6acbece5e5a649915c1f65874b0e4a60c',
       i686: 'deb977ac7d8b188595e7d132124755caffa420acd4e9de92c854c20e8ba510e7',
     x86_64: '821ef3a3ef5d3048450e3ca407023aa47dabf2d6dd0fd3d5658afb33e8a861c3'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
  depends_on 'zstd' # R

  no_env_options

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        -DBUILD_TESTING=OFF \
        -DMOLD_LTO=ON \
        -DMOLD_USE_MOLD=ON \
        -Wno-dev \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
