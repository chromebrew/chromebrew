require 'package'

class Sqlitebrowser < Package
  description 'DB Browser for SQLite (DB4S) is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite'
  homepage 'https://sqlitebrowser.org'
  version '3.11.2'
  source_url 'https://github.com/sqlitebrowser/sqlitebrowser/archive/v3.11.2.tar.gz'
  source_sha256 '298acb28878aa712277a1c35c185b07a5a1671cc3e2c6a21b323477b91d486fc'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'sqlite'
  depends_on 'qtbase'

  def self.build
    system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
