require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '9.5.0'
  source_url 'https://ftp.postgresql.org/pub/source/v9.5.0/postgresql-9.5.0.tar.bz2'
  source_sha256 'f1c0d3a1a8aa8c92738cab0153fbfffcc4d4158b3fee84f7aa6bfea8283978bc'

  depends_on 'buildessential'
  depends_on 'zlibpkg'

  def self.build
    system "./configure"
    system "make world"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-world"
    out = "#{CREW_DEST_DIR}/usr/local/pgsql/data"
    system "mkdir", out
    puts "------------------"
    puts "Installation success!"
    puts "To get started, you need to initialize a database directory"
    puts "'echo \"export PATH=/usr/local/pgsql/bin:$PATH\" >> ~/.bashrc'"
    puts "'source ~/.bashrc'"
    puts "'chmod 700 /usr/local/pgsql/data'"
    puts "'initdb -D /usr/local/pgsql/data'"
    puts "To start postgres: 'pg_ctl -D /usr/local/pgsql/data -l logfile start'"
    puts "To stop postgres: 'pg_ctl -D /usr/local/pgsql/data stop'"
    puts "Create a database: 'createdb <dbname>'"
    puts "Connect to database: 'psql <dbname>'"
  end
end
