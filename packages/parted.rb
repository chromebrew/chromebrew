require 'package'

class Parted < Package
  description 'Create, destroy, resize, check, copy partitions and file systems.'
  homepage 'https://www.gnu.org/software/parted'
  @_ver = '3.4'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/parted/parted-#{@_ver}.tar.xz"
  source_sha256 'e1298022472da5589b7f2be1d5ee3c1b66ec3d96dfbad03dc642afd009da5342'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/parted-3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'ede8edf189c6a15f7f73c5473230e183e658515392727cf263bcec6f6e7a3145',
      armv7l: 'ede8edf189c6a15f7f73c5473230e183e658515392727cf263bcec6f6e7a3145',
        i686: '0105eb1b9b74e671c2a8e2798ecbf45aa52cddc2a7a9c92de57716f6652a5229',
      x86_64: '516dcdcb2ff040ed538a79f74d5f409b6059641620f6b8b239b584637513ec3e',
  })

  depends_on 'lvm2'
  depends_on 'ncurses'
  depends_on 'readline'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
