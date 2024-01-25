require 'package'

class Shhopt < Package
  description 'C-functions for parsing command line options, both traditional one-character options, and GNU\'ish --long-options.'
  homepage 'http://shh.thathost.com/pub-unix/#sshopt'
  version '1.1.7-2'
  license 'Artistic'
  compatibility 'all'
  source_url 'http://shh.thathost.com/pub-unix/files/shhopt-1.1.7.tar.gz'
  source_sha256 'bae94335124efa6fcc2f0a55cabd68c9c90be935bcdb8054d7e5188e0d5da679'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shhopt/1.1.7-2_armv7l/shhopt-1.1.7-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shhopt/1.1.7-2_armv7l/shhopt-1.1.7-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shhopt/1.1.7-2_i686/shhopt-1.1.7-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/shhopt/1.1.7-2_x86_64/shhopt-1.1.7-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0554b4732ed0ae4b6435e79e81acc858763ec033b558db3a5f0b17c0571e69c0',
     armv7l: '0554b4732ed0ae4b6435e79e81acc858763ec033b558db3a5f0b17c0571e69c0',
       i686: '4deb1c5f1e94fcadbbaf10fa4526a82c9c9b03e55048662febc9224f16fdf467',
     x86_64: '7d33f27ea21b12427c1b1cebfedd18172ecd9bb932910810e799d0c76dd43e7a'
  })

  def self.patch
    `sed -i 's/.*#SHARED.*1.*/SHARED=1/' Makefile` # enable shared
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "INSTBASEDIR=#{CREW_DEST_PREFIX}", "INSTLIBDIR=#{CREW_DEST_LIB_PREFIX}", 'install'
  end
end
