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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11-1_armv7l/gzip-1.11-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11-1_armv7l/gzip-1.11-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11-1_i686/gzip-1.11-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.11-1_x86_64/gzip-1.11-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5c4954aaa1c00dcc32597bdc4944b4a72069c961aac8f1ad452ec11bb8d077c2',
     armv7l: '5c4954aaa1c00dcc32597bdc4944b4a72069c961aac8f1ad452ec11bb8d077c2',
       i686: 'b8a64ca517e857589edc251bd0cd26228731aa0bd309d46dc2972f0d4f19f7e7',
     x86_64: '68e5e94f9af0b15a87d30482ba38bf00cde21e8eb841bd8421410000712574b4',
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
