require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/en/stable/README/'
  version '1.4.0'

  case ARCH
  when 'i686'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.4.0/stack-1.4.0-linux-i386.tar.gz'
    source_sha256 'aabd307f7dcb585a7821d7b44a73527f0928a76c48711e6968262ee87c86bc14'
  when 'x86_64'
    source_url 'https://github.com/commercialhaskell/stack/releases/download/v1.4.0/stack-1.4.0-linux-x86_64.tar.gz'
    source_sha256 '618a309d763432a2cca654bc29249a77c7de096c693a28b84dd3656470269f5a'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/stack-1.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5d372b2453b33a0e22e929e50b0eef9893c881b65a6a00f8a3c722ede57a9bf4',
     armv7l: '5d372b2453b33a0e22e929e50b0eef9893c881b65a6a00f8a3c722ede57a9bf4',
       i686: '2b1103372503767cf3982ce07a2fc9f7ea97bc3e4cee0e27703285f4a9561eea',
     x86_64: '85be48d282df764cec7139ffd6e2c9f4b05e437b5b24cba371cdc5dab982c41f',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp stack #{CREW_DEST_DIR}/usr/local/bin"
  end
end
