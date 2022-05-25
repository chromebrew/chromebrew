# Adapted from Arch Linux catatonit PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/catatonit/trunk/PKGBUILD

require 'package'

class Catatonit < Package
  description 'A container init that is so simple its effectively brain-dead.'
  homepage 'https://github.com/openSUSE/catatonit/'
  version '0.1.7'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/catatonit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/catatonit/0.1.7_armv7l/catatonit-0.1.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/catatonit/0.1.7_armv7l/catatonit-0.1.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/catatonit/0.1.7_i686/catatonit-0.1.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/catatonit/0.1.7_x86_64/catatonit-0.1.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e53312d2dfe70cb4983c842faa39bbfbec1482057669e98d2a3920203182c944',
     armv7l: 'e53312d2dfe70cb4983c842faa39bbfbec1482057669e98d2a3920203182c944',
       i686: '236251e20bb00af261ac86787ae40db52d54e99b4c1007a294d2f1e353e174b7',
     x86_64: '56ce55a9a73f365b7d46577b7ee0df920a45a541a97c15a155c3037a5d534ebf'
  })

  def self.patch
    downloader 'https://github.com/openSUSE/catatonit/commit/99bb9048f532257f3a2c3856cfa19fe957ab6cec.patch',
               '93e0429aa58cecea6cf2a8727bcc53e6eca90da63305a24c4f826b5e31c90d1a'
    downloader 'https://patch-diff.githubusercontent.com/raw/openSUSE/catatonit/pull/24.patch',
               '101f6483b5f9d66c91c098bd125b17dd7da0b9ca7b01bd0e7c721bd075cd71bd'
    system 'patch -Np1 -i 99bb9048f532257f3a2c3856cfa19fe957ab6cec.patch'
    system 'patch -Np1 -i 24.patch'
  end

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS}"
    system 'make V=1'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
