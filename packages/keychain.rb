require 'package'

class Keychain < Package
  description 'Keychain helps you to manage SSH and GPG keys in a convenient and secure manner.'
  homepage 'https://www.funtoo.org/Keychain'
  version '2.8.5'
  source_url 'https://github.com/funtoo/keychain/archive/2.8.5.tar.gz'
  source_sha256 'dcce703e5001211c8ebc0528f45b523f84d2bceeb240600795b4d80cb8475a0b'

  binary_url ({
  })
  binary_sha256 ({
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
