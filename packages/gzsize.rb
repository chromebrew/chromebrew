require 'package'

class Gzsize < Package
  description 'Print the uncompressed size of a GZipped file.'
  homepage 'https://bfontaine.github.io/gzsize/'
  version '0.1.1'
  source_url 'https://github.com/bfontaine/gzsize/archive/0.1.1.tar.gz'
  source_sha1 '778820b0bf3fc2197955b60c6dc49f6fac00878b'

  def self.build
    system "make"
  end

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir", "-p", "#{CREW_DEST_DIR}/usr/local/man/man1"
    FileUtils.cp "gzsize", "#{CREW_DEST_DIR}/usr/local/bin/gzsize"
    FileUtils.cp "man/gzsize.1", "#{CREW_DEST_DIR}/usr/local/man/man1/gzsize.1"
  end
end
