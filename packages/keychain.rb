require 'package'

class Keychain < Package
  description 'Keychain helps you to manage SSH and GPG keys in a convenient and secure manner.'
  homepage 'https://www.funtoo.org/Keychain'
  version '2.8.5'
  compatibility 'all'
  source_url 'https://github.com/funtoo/keychain/archive/2.8.5.tar.gz'
  source_sha256 'dcce703e5001211c8ebc0528f45b523f84d2bceeb240600795b4d80cb8475a0b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/keychain-2.8.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/keychain-2.8.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/keychain-2.8.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/keychain-2.8.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e494cfd41ed3215757cf656b36a7b483f8a0e007fb5963d2e6b058c701f6ff44',
     armv7l: 'e494cfd41ed3215757cf656b36a7b483f8a0e007fb5963d2e6b058c701f6ff44',
       i686: '539b7395d19f08d1a914070b889f240fe890fc0abf7b298d62597bcc72b9916f',
     x86_64: '4b4aead7a52d97ef7acfc5695952e57b35c3c12935b4fde6ce3ed5e64705ec0a',
  })

  def self.install
    system "gzip -9 keychain.1"
    system "install -Dm755 keychain #{CREW_DEST_PREFIX}/bin/keychain"
    system "install -Dm644 keychain.1.gz #{CREW_DEST_PREFIX}/share/man/man1/keychain.1.gz"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/keychain"
    system "rm -f .gitignore keychain keychain.1.gz keychain.spec.in keychain.spec keychain.pod Makefile"
    system "cp -r . #{CREW_DEST_PREFIX}/share/keychain"
  end
end
