require 'package'

class Q < Package
  description 'q is a command line tool that allows direct execution of SQL-like queries on CSVs/TSVs (and any other tabular text files).'
  homepage 'http://harelba.github.io/q/'
  version '1.7.1'
  compatibility 'all'
  source_url 'https://github.com/harelba/q/archive/1.7.1.tar.gz'
  source_sha256 'cf0f2ca3ecb88fedf6232d5ce5931afc90eae1db8fdef78b17933d46e9f9f678'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/q-1.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/q-1.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/q-1.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/q-1.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '04016db78b39035e66a0e6a3ed12e7bec1b7e497b2dff89dbb9a02d8b74a6bfa',
     armv7l: '04016db78b39035e66a0e6a3ed12e7bec1b7e497b2dff89dbb9a02d8b74a6bfa',
       i686: '3be0918a64369228dd23881368bd8e091f5008cdabd14541af5c4f8820293926',
     x86_64: 'd1c9c44e976208687c4f0a52e631cce825fefa737b5aedf19c252db9bd99019c',
  })

  depends_on 'python27'
  depends_on 'sqlite'

  def self.install
    system "install -Dm755 bin/q #{CREW_DEST_PREFIX}/bin/q"
  end
end
