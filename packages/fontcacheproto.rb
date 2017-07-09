require 'package'

class Fontcacheproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.13'
  source_url 'https://www.x.org/archive/individual/proto/fontcacheproto-0.1.3.tar.gz'
  source_sha256 '759b4863b55a25bfc8f977d8ed969da0b99b3c823f33c674d6da5825f9df9a79'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fontcacheproto-0.13-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fontcacheproto-0.13-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/fontcacheproto-0.13-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/fontcacheproto-0.13-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e666bf952cd8b9b72d5028727a4488e35a0c733bfa1e4d70276b740e27aca81e',
     armv7l: 'e666bf952cd8b9b72d5028727a4488e35a0c733bfa1e4d70276b740e27aca81e',
       i686: 'f5ce227919c64ef324f017162315cf9ebc6830b143b562ccb74bde03511a1bbf',
     x86_64: '7ebd3cd5f640d40aed395f87b18eafcb89b4ca05e05370dead73d7fb99eb0e56',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
