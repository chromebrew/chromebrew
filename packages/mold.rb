# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.4.2-183e4db6'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag '183e4db6965df206111d9c6ef381cd8d995a983c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-183e4db6_armv7l/mold-1.4.2-183e4db6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-183e4db6_armv7l/mold-1.4.2-183e4db6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-183e4db6_i686/mold-1.4.2-183e4db6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.2-183e4db6_x86_64/mold-1.4.2-183e4db6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '82ff6dab674b598e397cd6aa0e2cd3910cfe1ccc0a9d14293bbd86b05877ab88',
     armv7l: '82ff6dab674b598e397cd6aa0e2cd3910cfe1ccc0a9d14293bbd86b05877ab88',
       i686: '648ecaf27789e9c5290486393f2ee5833d631fd6a2bba44a0915f0bb3453b486',
     x86_64: 'c02262473460f2764f55d05e52bda1a1362d6d9580cda4a3deab1c43b079689a'
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
