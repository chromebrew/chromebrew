require 'package'

class Xe < Package
  description 'simple xargs and apply replacement.'
  homepage 'https://github.com/chneukirchen/xe/'
  version '0.6.1'
  source_url 'https://github.com/chneukirchen/xe/archive/v0.6.1.tar.gz'
  source_sha256 '36036d0e9464233d3113af187c473491298ed1168976330d7dd615b8f0521b96'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xe-0.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '607a454d0b65354af237dac375d1c843678d91210f1b75920a58041d1e281fa3',
     armv7l: '607a454d0b65354af237dac375d1c843678d91210f1b75920a58041d1e281fa3',
       i686: '7ff098ce7404dda0f738f4cef7cb53b2cb1a06d9cd7b6177c306b78a83f7a7ad',
     x86_64: '52116a8484a83a68bd756e4fb4adaa5d31b5b47c2416a6ac6d60b080fb4a5c80',
  })

  def self.build
    system "make", "PREFIX=/usr/local"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
