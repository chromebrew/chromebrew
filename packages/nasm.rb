require 'package'

class Nasm < Package
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  @_ver = '2.15.05'
  version @_ver
  compatibility 'all'
  source_url 'https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.xz'
  source_sha256 '3caf6729c1073bf96629b57cee31eeb54f4f8129b01902c73428836550b30a3f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.15.05-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.15.05-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.15.05-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.15.05-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '341d485bb248ed27fa1deaf10d361ab13eb9ac8332298cb45d3c2199e01aca25',
     armv7l: '341d485bb248ed27fa1deaf10d361ab13eb9ac8332298cb45d3c2199e01aca25',
       i686: 'e78c9d471c116b2ced338a800b84a01346e964b377b0fd66f260ef517da8e801',
     x86_64: '920e5d3591a66153b45d68c3e67bca8ef74cfc6cf3d71e2c4c57c5624a2b5111'
  })

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
