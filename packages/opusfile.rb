# Adapted from Arch Linux opusfile PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/opusfile/trunk/PKGBUILD

require 'package'

class Opusfile < Package
  description 'Library for opening, seeking, and decoding .opus files'
  homepage 'https://opus-codec.org/'
  version '0.12-9d71834'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/xiph/opusfile.git'
  git_hashtag '9d718345ce03b2fad5d7d28e0bcd1cc69ab2b166'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opusfile/0.12-9d71834_armv7l/opusfile-0.12-9d71834-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opusfile/0.12-9d71834_armv7l/opusfile-0.12-9d71834-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opusfile/0.12-9d71834_i686/opusfile-0.12-9d71834-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opusfile/0.12-9d71834_x86_64/opusfile-0.12-9d71834-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3831e7c8d77a9eb3990f410254a795699bd00bdcbd4e2a1979ba481426ac940e',
     armv7l: '3831e7c8d77a9eb3990f410254a795699bd00bdcbd4e2a1979ba481426ac940e',
       i686: 'd52cd85b88ef2bd777fcc4728efdb1ad9ef703c62400041c25cf3921fbc72751',
     x86_64: 'ce016ac8c0ece57300e6314f568f3c95362f765278d687adc5dfa12b89bbaa6f'
  })

  depends_on 'glibc' # R
  depends_on 'libogg' # R
  depends_on 'openssl' # R
  depends_on 'opus' # R

  git_fetchtags

  def self.patch
    downloader 'https://github.com/xiph/opusfile/pull/35.patch',
               '0dfb34854a044625e6150d7571f48620c5faf9c13e72568980caa4cb20ea283f'
    system 'patch -Np1 -i 35.patch'
    downloader 'https://github.com/xiph/opusfile/pull/40.patch',
               '3600361b3894194a4f89f4c3f6614d6f97a0787d6dbe2235d47625e730ed03ec'
    system 'patch -Np1 -i 40.patch'
  end

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
