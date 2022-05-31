require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.12'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.12.tar.xz'
  source_sha256 'ce5e03e519f637e1f814011ace35c4f87b33c0bbabeec35baf5fbd3479e91956'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-threads=posix"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
