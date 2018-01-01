require 'package'

class Gzsize < Package
  description 'Print the uncompressed size of a GZipped file.'
  homepage 'https://bfontaine.github.io/gzsize/'
  version '1.2'
  source_url 'https://github.com/bfontaine/gzsize/archive/0.1.2.tar.gz'
  source_sha256 '32e20cb2e570f16bc30e62c4fda406ede23b23dfd313fc82528173827487b170'

  binary_url ({
  })
  binary_sha256 ({
  })

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
