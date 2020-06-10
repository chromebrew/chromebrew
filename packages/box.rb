require 'package'

class Box < Package
  description 'An application for building and managing Phars.'
  homepage 'https://box-project.github.io/box2/'
  version '2.7.5'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/box-project/box2/2.7.5/README.md'
  source_sha256 'b60e231f431cefbd88fc4022af5408c2098242f45485180d87ad88dbd30e6d02'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/box-2.7.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/box-2.7.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/box-2.7.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/box-2.7.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2dd48393354f030d4324a9fde5ea1b57d809c14f87b96fd8e70af8b6c9c1b8a7',
     armv7l: '2dd48393354f030d4324a9fde5ea1b57d809c14f87b96fd8e70af8b6c9c1b8a7',
       i686: 'c4cedb50c2b0fe21ac7a38c73fe73c20914346eabb8f4d106cdaf2d59ef18e41',
     x86_64: '97fa161d1715dac2b44d477e385bfa10bf55f182b7907d8ec125231ca82e6ca2',
  })

  depends_on 'php' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    system 'wget https://github.com/box-project/box2/releases/download/2.7.5/box-2.7.5.phar'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('box-2.7.5.phar') ) == '28b4b798ad4dcf8fbf9cd68aaff495d4bbeaec4363f5f319a222829d9b6abdfe'
    system "install -Dm755 box-2.7.5.phar #{CREW_DEST_PREFIX}/bin/box"
  end
end
