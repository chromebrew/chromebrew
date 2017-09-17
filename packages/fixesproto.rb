require 'package'

class Fixesproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '5.0'
  source_url 'https://www.x.org/archive/individual/proto/fixesproto-5.0.tar.gz'
  source_sha256 '67865a0e3cdc7dec1fd676f0927f7011ad4036c18eb320a2b41dbd56282f33b8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fixesproto-5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8f97260127449809bdd13b66bf6878bd23d56cf41f41a7860737aa5c67d83315',
     armv7l: '8f97260127449809bdd13b66bf6878bd23d56cf41f41a7860737aa5c67d83315',
       i686: '07f5f0b8e534bc08a5108867838e835ac7faa1abd3deadd5547b448862d479ef',
     x86_64: '66fa1477e469a4cbbe5ebcf568fff3dc32f91c8ff8dfeddb0769fd43fbcc264a',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
