require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.3.4'
  source_url 'https://sourceforge.net/projects/dos2unix/files/dos2unix/7.3.4/dos2unix-7.3.4.tar.gz'
  source_sha256 '8ccda7bbc5a2f903dafd95900abb5bf5e77a769b572ef25150fde4056c5f30c5'

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp dos2unix #{CREW_DEST_DIR}/usr/local/bin"
    system "cp mac2unix #{CREW_DEST_DIR}/usr/local/bin"
    system "cp unix2dos #{CREW_DEST_DIR}/usr/local/bin"
    system "cp unix2mac #{CREW_DEST_DIR}/usr/local/bin"
  end
end
