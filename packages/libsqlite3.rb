require 'package'

class Libsqlite3 < Package
  description 'SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine.'
  homepage 'https://github.com/LuaDist/libsqlite3'
  version '3.7.7.1'
  source_url 'https://github.com/LuaDist/libsqlite3/archive/3.7.7.1.tar.gz'
  source_sha1 '43a8eaad04a2220e9ede5764da8edba4003ad33a'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
