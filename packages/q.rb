require 'package'

class Q < Package
  description 'q is a command line tool that allows direct execution of SQL-like queries on CSVs/TSVs (and any other tabular text files).'
  homepage 'http://harelba.github.io/q/'
  version '1.7.1'
  source_url 'https://github.com/harelba/q/archive/1.7.1.tar.gz'
  source_sha256 'cf0f2ca3ecb88fedf6232d5ce5931afc90eae1db8fdef78b17933d46e9f9f678'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'
  depends_on 'sqlite'

  def self.install
    system "install -Dm755 bin/q #{CREW_DEST_PREFIX}/bin/q"
  end
end
