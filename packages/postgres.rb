require 'package'

class Postgres < Package
  version '9.4.4'
  source_url 'https://ftp.postgresql.org/pub/source/v9.4.4/postgresql-9.4.4.tar.bz2'
  source_sha1 'e295fee0f1bace740b2db1eaa64ac060e277d5a7'

  depends_on 'buildessential'

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
    puts "'sudo chown chronos:chronos /usr/local/pgsql/data'"
    puts "'sudo chmod 700 /usr/local/pgsql/data'"
    puts "'initdb -D /usr/local/pgsql/data'"
    puts "To run your database: 'pg_ctl -D /usr/local/pgsql/data -l logfile start'"
    puts "Create a database: 'createdb <dbname>'"
    puts "Connect to database: 'psql <dbname>'"
  end
end
