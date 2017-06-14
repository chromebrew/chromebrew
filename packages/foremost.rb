require 'package'

class Foremost < Package
  description 'Foremost is a console program to recover files based on their headers, footers, and internal data structures.'
  homepage 'http://foremost.sourceforge.net/'
  version '1.5.7'
  source_url 'http://foremost.sourceforge.net/pkg/foremost-1.5.7.tar.gz'
  source_sha1 'c26d68990d7bd5245d5f7dc83c9217642a7a2056'

  def self.build
    system "make"
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_DIR}/usr/local/bin", \
                       "#{CREW_DEST_DIR}/usr/local/man/man1", \
                       "#{CREW_DEST_DIR}/usr/local/etc"]
    FileUtils.cp_r 'foremost', "#{CREW_DEST_DIR}/usr/local/bin/"
    FileUtils.cp_r 'foremost.8.gz', "#{CREW_DEST_DIR}/usr/local/man/man1/foremost.1.gz"
    FileUtils.cp_r 'foremost.conf', "#{CREW_DEST_DIR}/usr/local/etc/"
  end
end
