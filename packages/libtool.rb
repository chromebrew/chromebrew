require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.4.7'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libtool/libtool-2.4.7.tar.xz'
  source_sha256 '4f7f217f057ce655ff22559ad221a0fd8ef84ad1fc5fcb6990cecc333aa1635d'

  depends_on 'm4'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-ltdl-install"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
