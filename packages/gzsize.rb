require 'package'

class Gzsize < Package
  description 'Print the uncompressed size of a GZipped file.'
  homepage 'https://bfontaine.github.io/gzsize/'
  version '0.1.1'
  source_url 'https://github.com/bfontaine/gzsize/archive/0.1.1.tar.gz'
  source_sha256 'ffb9cc1e5ed10443b1bcf2f711787bc7f69eee27ed83b48f2ccf9d80e39554dd'

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
