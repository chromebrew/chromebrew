require 'package'
  
class Tldr < Package
    description 'A collection of simplified and community-driven man pages.'
    homepage 'http://tldr.sh/'
    version '93cfb27'
    source_url 'https://raw.githubusercontent.com/raylee/tldr/93cfb278d2c56c3518a39ba3e01cbfc40423cc3b/tldr'
    source_sha256 '58cb21c28946d51db01b080853dc589773bb1b1e62f3a53306bc1f46cabcb66d'


   def self.install
       system "curl -o tldr https://raw.githubusercontent.com/raylee/tldr/93cfb278d2c56c3518a39ba3e01cbfc40423cc3b/tldr"
       abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('tldr') ) == '58cb21c28946d51db01b080853dc589773bb1b1e62f3a53306bc1f46cabcb66d'
       system "install -Dm755 tldr #{CREW_DEST_PREFIX}/bin/tldr"
   end
end
