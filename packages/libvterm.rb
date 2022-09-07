# Adapted from Arch Linux libvterm PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libvterm/trunk/PKGBUILD

require 'package'

class Libvterm < Package
  description 'Abstract library implementation of a VT220/xterm/ECMA-48 terminal emulator'
  homepage 'https://www.leonerd.org.uk/code/libvterm/'
  version '0.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.leonerd.org.uk/code/libvterm/libvterm-0.2.tar.gz'
  source_sha256 '4c5150655438cfb8c57e7bd133041140857eb04defd0e544521c0e469258e105'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvterm/0.2_armv7l/libvterm-0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvterm/0.2_armv7l/libvterm-0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvterm/0.2_i686/libvterm-0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvterm/0.2_x86_64/libvterm-0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd6657b597dcd4cbe25c765ac04acdaa3962809921bcdb1d439f794481d112374',
     armv7l: 'd6657b597dcd4cbe25c765ac04acdaa3962809921bcdb1d439f794481d112374',
       i686: '043f3366932dff21028fc1042b6d3f0506160645413a311079284df9356939ec',
     x86_64: '51a0aa91d1c4ca302c621afae3b379d40a2c66fd82ad9b64327177af9e016956'
  })

  depends_on 'glibc'
  depends_on 'git' => :build

  def self.build
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
