require 'package'

class Libsodium < Package
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.16'
  source_url 'https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz'
  source_sha256 'eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c3899e082014a5fd32ee2736d7c0a9d0cb8256247da9723a31e4dc85ddb5a6e',
     armv7l: '3c3899e082014a5fd32ee2736d7c0a9d0cb8256247da9723a31e4dc85ddb5a6e',
       i686: 'a36f6638877150233722e11c8d669fc2044edcb6da83f6b9e1b56d1288cda2d8',
     x86_64: 'a24fc250462688409af619df906a7e83a2a27d923cc51fe332e316fb580eb676',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
