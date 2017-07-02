require 'package'

class Libsqlite3 < Package
  description 'SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine.'
  homepage 'https://github.com/LuaDist/libsqlite3'
  version '3.7.7.1'
  source_url 'https://github.com/LuaDist/libsqlite3/archive/3.7.7.1.tar.gz'
  source_sha256 'b1eb700a46a7429a1a587fadd31e8ef5a3fd84bb6a75b898715baf71fedc412e'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
