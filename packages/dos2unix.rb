require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.4.0'
  source_url 'https://downloads.sourceforge.net/project/dos2unix/dos2unix/7.4.0/dos2unix-7.4.0.tar.gz'
  source_sha256 'bac765abdbd95cdd87a71989d4382c32cf3cbfeee2153f0086cb9cf18261048a'

  depends_on 'gettext' => :build

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
