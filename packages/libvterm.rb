# Adapted from Arch Linux libvterm PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libvterm/trunk/PKGBUILD

require 'package'

class Libvterm < Package
  description 'Abstract library implementation of a VT220/xterm/ECMA-48 terminal emulator'
  homepage 'https://www.leonerd.org.uk/code/libvterm/'
  version '0.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.leonerd.org.uk/code/libvterm/libvterm-0.3.tar.gz'
  source_sha256 '61eb0d6628c52bdf02900dfd4468aa86a1a7125228bab8a67328981887483358'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63bd50be7529cb4ae529474030be223abce26c0edc1c38f64f57adc7c9b0eacd',
     armv7l: '63bd50be7529cb4ae529474030be223abce26c0edc1c38f64f57adc7c9b0eacd',
       i686: '33de59b348d3bfe9b10980378daa205b604c49a07a39089beefa34ba909cea63',
     x86_64: 'fb1046fabd96fb9f241b4ae4dc5e2b04e9aeb04efd0a873cdd0fff2e9601af24'
  })

  depends_on 'glibc'

  def self.build
    system "mold -run make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
