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
     aarch64: '6ad97e1adad7137bf83a14b949829e9ac409d03142cb09f0e189e58894d2b0e5',
      armv7l: '6ad97e1adad7137bf83a14b949829e9ac409d03142cb09f0e189e58894d2b0e5',
        i686: '2eab1c80dc532c63057f522f475f73c894d15675d229fe93fa9193c49bf2cc16',
      x86_64: '1b5dfc370d91ad8f8aa0ca9e9ff088656b46a69510ceb6876d02e5e0fe32e07d',
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
      --sbindir=/usr/bin"
    system "make"
  end
  
  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} sbindir=/usr/bin install"
  end
end
