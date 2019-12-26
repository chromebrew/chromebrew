require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '9.6.16'
  source_url 'https://ftp.postgresql.org/pub/source/v9.6.16/postgresql-9.6.16.tar.bz2'
  source_sha256 '5c6cba9cc0df70ba2b128c4a87d0babfce7c0e2b888f70a9c8485745f66b22e7'

  binary_url ({
  })
  binary_sha256 ({
  })

  # Feel free to change this directory prior to compiling.
  PGDATA = "#{CREW_PREFIX}/data/pgsql"

  def self.build
    system "sed -i 's,PGDATA=\"/usr/local/pgsql/data\",PGDATA=\"#{PGDATA}\",' contrib/start-scripts/linux"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make world"
  end

  def self.install
    # This conditional is needed for installation only.
    unless Dir.exists? "#{PGDATA}"
      system "mkdir", "-p", "#{PGDATA}"
      system "chmod", "700", "#{PGDATA}"
    end
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-world"
  end

  def self.postinstall
    # This conditional is needed for installation only.  If this package is updated in the future,
    # there is no need to initialize the data directory and display messages again.
    unless File.exists? "#{PGDATA}/PG_VERSION"
      system "initdb -D #{PGDATA}"
      puts
      puts "To complete the installation, execute the following:".lightblue
      puts "echo 'export PGDATA=\"#{PGDATA}\"' >> ~/.bashrc && source ~/.bashrc".lightblue
      puts
      puts "To start postgres: pg_ctl -l logfile start".lightblue
      puts "To stop postgres: pg_ctl stop".lightblue
      puts "Create a database: createdb <dbname>".lightblue
      puts "Connect to database: psql <dbname>".lightblue
      puts
    end
  end
end
