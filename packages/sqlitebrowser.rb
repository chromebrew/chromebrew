require 'package'

class Sqlitebrowser < Package
  description 'DB Browser for SQLite (DB4S) is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite'
  homepage 'https://sqlitebrowser.org'
  version '3.11.2'
  license 'GPL-3 and MPL-2.0'
  compatibility 'all'
  source_url 'https://github.com/sqlitebrowser/sqlitebrowser/archive/v3.11.2.tar.gz'
  source_sha256 '298acb28878aa712277a1c35c185b07a5a1671cc3e2c6a21b323477b91d486fc'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a2ef3c40eb1eed02125a24b2b4d9ffaa81d9dfa4be9042ddf410c53cdcf6eab7',
     armv7l: 'a2ef3c40eb1eed02125a24b2b4d9ffaa81d9dfa4be9042ddf410c53cdcf6eab7',
       i686: '116f831ced1a81c4d2bd7dfc6fc29f31b6cbd2ca6101605cdcbab789bf155e31',
     x86_64: 'b4213ade6b79ad9a03f2062c08dfde249009f0de6115b94e15b37edfc087949e'
  })

  depends_on 'sqlite'
  depends_on 'qt5_base'
  depends_on 'sommelier'

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
