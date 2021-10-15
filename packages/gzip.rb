require 'package'

class Gzip < Package
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.11-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.11.tar.xz'
  source_sha256 '9b9a95d68fdcb936849a4d6fada8bf8686cddf58b9b26c9c4289ed0c92a77907'

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
