require 'package'
  
class Tldr < Package
  description 'A collection of simplified and community-driven man pages.'
  homepage 'http://tldr.sh/'
  version '93cfb27'
  source_url 'https://github.com/raylee/tldr/archive/93cfb278d2c56c3518a39ba3e01cbfc40423cc3b.tar.gz'
  source_sha256 'd565c6bdc594b87bf204fa35b3059011931a3cb59b935812c8a8a5fbe1fbd5e5'

  def self.install
    system "install -Dm755 tldr #{CREW_DEST_PREFIX}/bin/tldr"
  end
end
