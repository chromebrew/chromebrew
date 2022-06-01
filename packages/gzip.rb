require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.12'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.12.tar.xz'
  source_sha256 'ce5e03e519f637e1f814011ace35c4f87b33c0bbabeec35baf5fbd3479e91956'

  binary_url({
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_i686/gzip-1.11-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.12_x86_64/gzip-1.12-chromeos-x86_64.tar.zst',
   aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.12_armv7l/gzip-1.12-chromeos-armv7l.tar.zst',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.12_armv7l/gzip-1.12-chromeos-armv7l.tar.zst'
  })
  binary_sha256({
      i686: 'dd638a8e748003937fb955f97c2112affe77ba7c4a041b89778abce0ccd81794',
    x86_64: '605605a9eb7f26b799b07b8246f80a82b7ab8a16a3749a393763a4401497bfda',
   aarch64: '2a699b3eba6ff714a780e8c2c32131c842f2960d2eb04de280268c54d111aed1',
    armv7l: '2a699b3eba6ff714a780e8c2c32131c842f2960d2eb04de280268c54d111aed1'
  })

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
