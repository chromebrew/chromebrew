require 'package'
  
class Tldr < Package
  description 'A collection of simplified and community-driven man pages.'
  homepage 'http://tldr.sh/'
  version '93cfb27'
  compatibility 'all'
  source_url 'https://github.com/raylee/tldr/archive/93cfb278d2c56c3518a39ba3e01cbfc40423cc3b.tar.gz'
  source_sha256 'd565c6bdc594b87bf204fa35b3059011931a3cb59b935812c8a8a5fbe1fbd5e5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tldr-93cfb27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tldr-93cfb27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tldr-93cfb27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tldr-93cfb27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '50b8a689875f48dbc91e3b9b7951907dd3f40a2292ab269037b4cb4095e22ddc',
     armv7l: '50b8a689875f48dbc91e3b9b7951907dd3f40a2292ab269037b4cb4095e22ddc',
       i686: 'be993d6193f793920125ff7521f557a19ecff4fd67fd8306b8e3e6e8c40d6427',
     x86_64: '823e0b61fb8d1c193e57c0ba82019622bee800a717a4682af9a701b5f5f43173',
  })

  def self.install
    system "install -Dm755 tldr #{CREW_DEST_PREFIX}/bin/tldr"
  end
end
