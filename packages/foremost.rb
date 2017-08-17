require 'package'

class Foremost < Package
  description 'Foremost is a console program to recover files based on their headers, footers, and internal data structures.'
  homepage 'http://foremost.sourceforge.net/'
  version '1.5.7'
  source_url 'http://foremost.sourceforge.net/pkg/foremost-1.5.7.tar.gz'
  source_sha256 '502054ef212e3d90b292e99c7f7ac91f89f024720cd5a7e7680c3d1901ef5f34'

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
