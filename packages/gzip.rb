require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.11-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.11.tar.xz'
  source_sha256 '9b9a95d68fdcb936849a4d6fada8bf8686cddf58b9b26c9c4289ed0c92a77907'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_armv7l/gzip-1.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_armv7l/gzip-1.11-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_i686/gzip-1.11-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11_x86_64/gzip-1.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ccd4cee7c674ecae22af29a49260bf07f5c1da2c4b7426ed786659be9d52d3c',
     armv7l: '3ccd4cee7c674ecae22af29a49260bf07f5c1da2c4b7426ed786659be9d52d3c',
       i686: '6a27145e7c7c41291aab7d6faf4c171e84b1359913788fad04e84c83bf4013c3',
     x86_64: '3ba5798e5713f61066ed9108c06322e14abcd2cbf3dd7d93535c7566fce5e4ad',
  })

  depends_on 'zutils' # L

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    # Remove conflicts with zutils
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/zcmp"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/zfgrep"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/zdiff"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/zegrep"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/zcat"
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/zgrep"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/zcmp.1"
    #FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/zfgrep.1"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/zdiff.1"
    #FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/zegrep.1"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/zcat.1"
    FileUtils.rm "#{CREW_DEST_MAN_PREFIX}/man1/zgrep.1"
  end

  def self.check
    system 'make', 'check'
  end
end
