require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'https://www.gnu.org/software/diffutils/'
  version '3.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/diffutils/diffutils-3.8.tar.xz'
  source_sha256 'a6bdd7d1b31266d11c4f4de6c1b748d4607ab0231af5188fc2533d0ae2438fec'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.8_armv7l/diffutils-3.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.8_armv7l/diffutils-3.8-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.8_i686/diffutils-3.8-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/diffutils/3.8_x86_64/diffutils-3.8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '60d8d2f9e575dcd421d7bc7ab9e531fb67098a3e9f0c9af80b34709926889843',
     armv7l: '60d8d2f9e575dcd421d7bc7ab9e531fb67098a3e9f0c9af80b34709926889843',
       i686: 'b59c68f3594f03870344182a68bddda9eba1ce19de32705ff0c44108c36b0aa0',
     x86_64: 'edddafc3090b7b146594d3b3d80c3c4cb8730c662b68eaaf2d90b42824368eb3'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
