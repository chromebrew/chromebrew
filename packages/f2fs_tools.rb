require 'package'

class F2fs_tools < Package
  description 'Tools for Flash-Friendly File System F2FS'
  homepage 'https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/about/'
  @_ver = '1.14.0'
  version @_ver
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/snapshot/f2fs-tools-#{@_ver}.tar.gz"
  source_sha256 '619263d4e2022152a1472c1d912eaae104f20bd227ce0bb9d41d1d6608094bd1'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/f2fs_tools-1.14.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/f2fs_tools-1.14.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/f2fs_tools-1.14.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/f2fs_tools-1.14.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '68b0d173285b156e90e7b8ef1283c0ce5b3b6b7273161baa7db8dc6a331d4e4a',
      armv7l: '68b0d173285b156e90e7b8ef1283c0ce5b3b6b7273161baa7db8dc6a331d4e4a',
        i686: '356f89bcbcc2fc12a91cfd7e63d86042cfd194554d34921c18b3c302e7277713',
      x86_64: '133257b9d9544223b40995c810154f806697ace336e4ef5ed6e51e29811d2aab',
  })

  depends_on 'util_linux'

  def self.patch
    # /usr/bin/sg_write_buffer is provided in sg3_utils"
    system "sed -i '/sg_write_buffer/d' tools/Makefile.am"
  end

  def self.build
    system "autoreconf -fi"
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin"
    system "make"
  end
  

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} sbindir=#{CREW_PREFIX}/bin install"
  end
end
