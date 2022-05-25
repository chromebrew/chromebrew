# Adapted from Arch Linux libminigbm-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libminigbm-git

require 'package'

class Libminigbm < Package
  description 'Generic Buffer Management GBM implementation used in Chromium OS'
  homepage 'https://chromium.googlesource.com/chromiumos/platform/minigbm/'
  git_hashtag '407eb0ebf3ce52fd4b3d79712d1b86d7b021c29b'
  version git_hashtag[0, 7]
  license 'custom'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/platform/minigbm.git'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libminigbm/407eb0e_armv7l/libminigbm-407eb0e-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libminigbm/407eb0e_armv7l/libminigbm-407eb0e-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libminigbm/407eb0e_i686/libminigbm-407eb0e-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libminigbm/407eb0e_x86_64/libminigbm-407eb0e-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a9d6aa263bdf80940c653730e45f969938a91f5a96c96d33fbd48df960b9f2a5',
     armv7l: 'a9d6aa263bdf80940c653730e45f969938a91f5a96c96d33fbd48df960b9f2a5',
       i686: 'f6390ce12b6a1b423de7b563ecd0a32156441e7002d1a28319902325f4cfd8b5',
     x86_64: '46f7449d05b06c5ce7bfeee667ea611e5f87b75d0033911b7c698b2709de3a1c'
  })

  depends_on 'libdrm'
  no_env_options

  def self.patch
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},g' gbm.pc"
    system "sed -i 's,libdir=${exec_prefix}/lib,libdir=${exec_prefix}/lib#{CREW_LIB_SUFFIX},g' gbm.pc"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS.gsub('-ffat-lto-objects', '').gsub('-fuse-ld=gold',
                                                                  '')} LIBDIR=#{CREW_LIB_PREFIX} make CC=clang"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} LIBDIR=#{CREW_LIB_PREFIX} install"
  end
end
