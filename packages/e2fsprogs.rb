# frozen_string_literal: true

require 'package'

class E2fsprogs < Package
  description 'e2fsprogs are ext2/3/4 file system utilities.'
  homepage 'http://e2fsprogs.sourceforge.net/'
  @_ver = '1.45.7'
  version @_ver
  compatibility 'all'
  source_url "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v#{@_ver}/e2fsprogs-#{@_ver}.tar.xz"
  source_sha256 '62d49c86d9d4becf305093edd65464484dc9ea41c6ff9ae4f536e4a341b171a2'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/e2fsprogs-1.45.7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4deb49e04d94878c4a9e4977a5aa01937c379cf332b56b4e93524f6a891bdbc1',
     armv7l: '4deb49e04d94878c4a9e4977a5aa01937c379cf332b56b4e93524f6a891bdbc1',
       i686: 'a950f3395704adfc93ec3207cfd5d62ae1c1def8c6e70cfb83e0a113092034c8',
     x86_64: '37e6c64a587dd9d984194a0d22829a36c93d4fac413675b00bd0d77091e210c6'
  })

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
