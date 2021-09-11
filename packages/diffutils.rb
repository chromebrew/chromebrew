require 'package'

class Diffutils < Package
  description 'GNU Diffutils is a package of several programs related to finding differences between files.'
  homepage 'https://www.gnu.org/software/diffutils/'
  version '3.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/diffutils/diffutils-3.8.tar.xz'
  source_sha256 'a6bdd7d1b31266d11c4f4de6c1b748d4607ab0231af5188fc2533d0ae2438fec'

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
