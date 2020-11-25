require 'package'

class Libdb < Package
  description 'Berkeley DB is a family of embedded key-value database libraries providing scalable high-performance data management services to applications.'
  homepage 'https://github.com/berkeleydb/libdb'
  version '5.3.28'
  compatibility 'all'
  source_url 'https://github.com/berkeleydb/libdb/releases/download/v5.3.28/db-5.3.28.tar.gz'
  source_sha256 'b19bf3dd8ce74b95a7b215be9a7c8489e8e8f18da60d64d6340a06e75f497749'


  def self.build
    Dir.chdir 'build_unix' do
      system "../dist/configure #{CREW_OPTIONS} --enable-dbm"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build_unix' do
      system "make", "docdir=#{CREW_PREFIX}/share/doc/db-5.3.28", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
