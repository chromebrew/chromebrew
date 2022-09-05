# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.4.2-7ffdcd4'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag '7ffdcd49d8cc30c34dbadbed1e93b4d15b3d9c15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-7ffdcd4_armv7l/mold-1.4.2-7ffdcd4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-7ffdcd4_armv7l/mold-1.4.2-7ffdcd4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-7ffdcd4_i686/mold-1.4.2-7ffdcd4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-7ffdcd4_x86_64/mold-1.4.2-7ffdcd4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3cf2f754d91e88b5d612e06a0a6c5378bc68b48c338f3e320a38d31ad628c1bf',
     armv7l: '3cf2f754d91e88b5d612e06a0a6c5378bc68b48c338f3e320a38d31ad628c1bf',
       i686: '193cdd254217fa1fa38bbb9b1c231ec9df2b54f3c82c34ee3bec6de294f376a5',
     x86_64: 'bf941ef112a31df67b52d60c77f93ae8e8b1dcc27c6f90aade9ba016647a2197'
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
        -DMOLD_USE_MOLD=ON \
        -DMOLD_LTO=ON \
        -Wno-dev \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
