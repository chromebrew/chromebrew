require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '9.6.5'
  source_url 'https://ftp.postgresql.org/pub/source/v9.6.5/postgresql-9.6.5.tar.bz2'
  source_sha256 '06da12a7e3dddeb803962af8309fa06da9d6989f49e22865335f0a14bad0744c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential'
  depends_on 'readline'
  depends_on 'zlibpkg'

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
