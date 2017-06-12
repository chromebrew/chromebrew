require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.3.4'
  source_url 'https://sourceforge.net/projects/dos2unix/files/dos2unix/7.3.4/dos2unix-7.3.4.tar.gz'
  source_sha1 'f19641741806b8411566144bfdf56df718b4aca0'

  def self.build
    system 'make'
    system 'make strip'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp dos2unix #{CREW_DEST_DIR}/usr/local/bin"
    system "cp mac2unix #{CREW_DEST_DIR}/usr/local/bin"
    system "cp unix2dos #{CREW_DEST_DIR}/usr/local/bin"
    system "cp unix2mac #{CREW_DEST_DIR}/usr/local/bin"
  end
end
