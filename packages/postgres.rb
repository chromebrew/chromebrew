require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '9.6.16'
  compatibility 'all'
  source_url 'https://ftp.postgresql.org/pub/source/v9.6.16/postgresql-9.6.16.tar.bz2'
  source_sha256 '5c6cba9cc0df70ba2b128c4a87d0babfce7c0e2b888f70a9c8485745f66b22e7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '867751a956524f30cb1f56d5f047eabcbf2602d3528872c20a1a75814c1d9cdd',
     armv7l: '867751a956524f30cb1f56d5f047eabcbf2602d3528872c20a1a75814c1d9cdd',
       i686: '949fad150bc9ee82d1b261ff9c58eb52cc71d47ce78a3a51594121b0d9504f40',
     x86_64: '99943c68314298f96c9cf43644b7092963e503ee03b6828067da12add581352e',
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
