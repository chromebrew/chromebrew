# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.5.1'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.1_armv7l/mold-1.5.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.1_armv7l/mold-1.5.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.1_i686/mold-1.5.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.5.1_x86_64/mold-1.5.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f1da60f74a1245e58f63653f51809a561148b686c7cd8e774bd1ac52e8d8adf6',
     armv7l: 'f1da60f74a1245e58f63653f51809a561148b686c7cd8e774bd1ac52e8d8adf6',
       i686: '206e00b6c434f3f8e4ed22908b1e553d04ef3b220df164b48b7d1e64b3cfd43d',
     x86_64: 'b5c722ab76e66be8d940aa35e3d78904948c5db767e9457fc88f230c2bdeec2a'
  })

  depends_on 'zlibpkg' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc' # R
  depends_on 'xxhash' => :build
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
