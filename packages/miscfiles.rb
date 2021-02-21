require 'package'

class Miscfiles < Package
  description 'A collection of files not of crucial importance for system administration or operation, but which have come to be common on various systems over the years.'
  homepage 'https://www.gnu.org/software/miscfiles/'
  version '1.5'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/miscfiles/miscfiles-1.5.tar.gz'
  source_sha256 '6aaaa8898b0f6dac18bcaa5492874a6cd1243ffbe7a6dd347ca8f3ec3642a500'

  def self.build
    system "./configure #{CREW_OPTIONS}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
