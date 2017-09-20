require 'package'

class Ascii < Package
  description 'List ASCII idiomatic names and octal/decimal code-point forms.'
  homepage 'http://www.catb.org/~esr/ascii/'
  version '3.16-1'
  source_url 'http://www.catb.org/~esr/ascii/ascii-3.16.tar.gz'
  source_sha256 'a94bb3970e8f1f63566f055517aecbdd46b11c4ccf142f77ffb80a79994f03a9'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp ascii #{CREW_DEST_PREFIX}/bin"
  end
end

