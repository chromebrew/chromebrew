# Adapted from Arch Linux cjson PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/cjson/trunk/PKGBUILD

require 'package'

class Cjson < Package
  description 'Ultralightweight JSON parser in ANSI C'
  homepage 'https://github.com/DaveGamble/cJSON'
  version '1.7.15'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/DaveGamble/cJSON/archive/v1.7.15.tar.gz'
  source_sha256 '5308fd4bd90cef7aa060558514de6a1a4a0819974a26e6ed13973c5f624c24b2'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cjson/1.7.15_armv7l/cjson-1.7.15-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cjson/1.7.15_armv7l/cjson-1.7.15-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cjson/1.7.15_i686/cjson-1.7.15-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cjson/1.7.15_x86_64/cjson-1.7.15-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '00cd4e939d680a9979c44f8007d0ff232fc1b4bda1b6f8325adbf9d3e8f34cf6',
     armv7l: '00cd4e939d680a9979c44f8007d0ff232fc1b4bda1b6f8325adbf9d3e8f34cf6',
       i686: 'ab346f52cef0555503e07ac58d97964da3986b5b7c2a1c1c9e7980efcc8ad861',
     x86_64: 'a74121d3420cec8975f7154d42e65e780de5ee07ad6b31d3380427035ce8148c'
  })

  depends_on 'glibc' # R

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
