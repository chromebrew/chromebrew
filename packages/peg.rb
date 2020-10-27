# Adapted from Arch Linux peg PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/peg/trunk/PKGBUILD

require 'package'

class Peg < Package
  description 'recursive-descent parser generators for C'
  version '0.1.18-2'
  source_url 'http://piumarta.com/software/peg/peg-0.1.18.tar.gz'
  source_sha256 '20193bdd673fc7487a38937e297fff08aa73751b633a086ac28c3b34890f9084'

  def self.build
    system "PREFIX=#{CREW_PREFIX} make"
  end
  def self.install
    system "PREFIX=#{CREW_PREFIX} ROOT=#{CREW_DEST_DIR} make install"
  end
end
