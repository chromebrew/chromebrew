require 'package'

class Postgres < Package
  version '9.3.2'
  source_url 'https://ftp.postgresql.org/pub/source/v9.3.2/postgresql-9.3.2.tar.bz2'
  source_sha1 'e1438f6cc8d387703dd1cca201316603266bd83a'

  depends_on 'buildessential'
 
  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    out = "#{CREW_DEST_DIR}/usr/local/pgsql/data"
    system "mkdir", out
    puts "------------------"
    puts "Installation success!"
    puts "To get started, you need to initialize a database directory"
    puts "'sudo chown chronos:chronos /usr/local/pgsql/data'"
    puts "'sudo chmod 700 /usr/local/pgsql/data'"
    puts "'initdb -D /usr/local/pgsql/data'"
    puts "To run your database: 'pg_ctl -D /usr/local/pgsql/data -l logfile start'"
    puts "Create a database: 'createdb <dbname>'"
    puts "Connect to database: 'psql <dbname>'"
  end
end
