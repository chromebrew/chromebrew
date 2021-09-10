require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.11'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.11.tar.xz'
  source_sha256 '9b9a95d68fdcb936849a4d6fada8bf8686cddf58b9b26c9c4289ed0c92a77907'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_armv7l/gzip-1.11-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_armv7l/gzip-1.11-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_i686/gzip-1.11-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_x86_64/gzip-1.11-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c9350be0932de35f6988748842ea5bb939b133add7f194f3b0d37f6ff55816bc',
     armv7l: 'c9350be0932de35f6988748842ea5bb939b133add7f194f3b0d37f6ff55816bc',
       i686: 'dd638a8e748003937fb955f97c2112affe77ba7c4a041b89778abce0ccd81794',
     x86_64: '605605a9eb7f26b799b07b8246f80a82b7ab8a16a3749a393763a4401497bfda'
  })

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
