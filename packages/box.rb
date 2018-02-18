require 'package'

class Box < Package
  description 'An application for building and managing Phars.'
  homepage 'https://box-project.github.io/box2/'
  version '2.7.5'
  source_url 'https://raw.githubusercontent.com/box-project/box2/2.7.5/README.md'
  source_sha256 'b60e231f431cefbd88fc4022af5408c2098242f45485180d87ad88dbd30e6d02'

  depends_on 'php' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system 'wget https://github.com/box-project/box2/releases/download/2.7.5/box-2.7.5.phar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('box-2.7.5.phar') ) == '28b4b798ad4dcf8fbf9cd68aaff495d4bbeaec4363f5f319a222829d9b6abdfe'
    system "install -Dm755 box-2.7.5.phar #{CREW_DEST_PREFIX}/bin/box"
  end
end
