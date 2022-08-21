# Adapted from Arch Linux mold PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/mold/trunk/PKGBUILD

require 'package'

class Mold < Package
  description 'A Modern Linker'
  homepage 'https://github.com/rui314/mold'
  version '1.4.1-14c8a11'
  compatibility 'all'
  source_url 'https://github.com/rui314/mold.git'
  git_hashtag '14c8a119f43fb46aba55bc89cf8a76a778906dca'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1-14c8a11_armv7l/mold-1.4.1-14c8a11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1-14c8a11_armv7l/mold-1.4.1-14c8a11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1-14c8a11_i686/mold-1.4.1-14c8a11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mold/1.4.1-14c8a11_x86_64/mold-1.4.1-14c8a11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '63df64b06817b3b656536a71e4fb02a663bec75a65690bd2307e63ca739f3236',
     armv7l: '63df64b06817b3b656536a71e4fb02a663bec75a65690bd2307e63ca739f3236',
       i686: '113f27b534d847c92e08dcfea9487bbce2424c00012aad4828d95f53418e78d7',
     x86_64: '266bd742e87b81e8d04d2abc95c99a48407d21eaac0be5e6e46bf905f25cabf5'
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
