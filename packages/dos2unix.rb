require 'package'

class Dos2unix < Package
  description 'dos2unix includes utilities to convert text files with DOS or Mac line endings to Unix line endings and vice versa.'
  homepage 'http://freecode.com/projects/dos2unix'
  version '7.3.5'
  source_url 'https://downloads.sourceforge.net/project/dos2unix/dos2unix/7.3.5/dos2unix-7.3.5.tar.gz'
  source_sha256 'a72caa2fb5cb739403315472fe522eda41aabab2a02ad6f5589639330af262e5'

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
