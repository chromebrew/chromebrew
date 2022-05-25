# Adapted from Arch Linux libxcvt PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libxcvt/trunk/PKGBUILD

require 'package'

class Libxcvt < Package
  description 'library providing a standalone version of the X server implementation of the VESA CVT standard timing modelines generator'
  homepage 'https://gitlab.freedesktop.org/xorg/lib/libxcvt'
  version '0.1.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcvt.git'
  git_hashtag "libxcvt-#{version}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcvt/0.1.1_armv7l/libxcvt-0.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcvt/0.1.1_armv7l/libxcvt-0.1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcvt/0.1.1_i686/libxcvt-0.1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcvt/0.1.1_x86_64/libxcvt-0.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6f230901f2a91504efc7257271c7be5a86a8529da06539c8d7cdf4cd6043a4f9',
     armv7l: '6f230901f2a91504efc7257271c7be5a86a8529da06539c8d7cdf4cd6043a4f9',
       i686: 'a9ebc81a0499580e61cb2754edd6e13e5cad82edcc472941a31109cda0084b44',
     x86_64: 'cd3e28274fcc9166d37f26738b9434b86626a48511d9729a7a60ab3ae7d2da6e'
  })

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
