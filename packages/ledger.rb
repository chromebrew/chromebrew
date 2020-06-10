require 'package'

class Ledger < Package
  description 'A double-entry accounting system with a command-line reporting interface'
  homepage 'https://www.ledger-cli.org/'
  version '3.1.3'
  compatibility 'all'
  source_url 'https://github.com/ledger/ledger/archive/v3.1.3.tar.gz'
  source_sha256 'b248c91d65c7a101b9d6226025f2b4bf3dabe94c0c49ab6d51ce84a22a39622b'

  binary_url ({
    aarch64: '',
     armv7l: '',
       i686: '',
     x86_64: '',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: '',
     x86_64: '',
  })

  depends_on 'boost' => :build

  def self.build
    system './acprep', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install/strip'
  end
end
