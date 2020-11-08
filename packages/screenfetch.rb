require 'package'

class Screenfetch < Package
  description 'Fetches system/theme information in terminal for Linux desktop screenshots.'
  homepage 'https://github.com/KittyKatt/screenFetch'
  version '3.9.1'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  depends_on 'bc'

  def self.build
    system "curl https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev -#o screenfetch-dev"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("screenfetch-dev") ) == '8841eabb5aa7c319f2b1f87dbac75a07f425b67888154a8779976319603732d0'
    system "curl https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch.1 -#o screenfetch.1"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("screenfetch.1") ) == '77ee19b1dc5c91e80d5d0d8e983b4c39928d58b0411b5f603fd7b26b765b6023'
    puts "Archive downloaded".lightgreen
  end

  def self.install
    system "install -Dm755 screenfetch-dev #{CREW_DEST_PREFIX}/bin/screenfetch"
    system "install -D screenfetch.1 #{CREW_DEST_PREFIX}/man/man1/screenfetch.1"
  end
end
