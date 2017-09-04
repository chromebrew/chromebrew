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

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "echo '#!/bin/bash' > pgctl"
    system "echo 'if [ \"$1\" == \"--help\" ]; then' >> pgctl"
    system "echo '  pg_ctl --help' >> pgctl"
    system "echo 'else' >> pgctl"
    system "echo '  pg_ctl -D #{CREW_PREFIX}/pgsql/data \"$@\"' >> pgctl"
    system "echo 'fi' >> pgctl"
    system "chmod +x pgctl"
    system "make world"
  end

  def self.install
    unless Dir.exists? "#{CREW_PREFIX}/pgsql/data"
      system "mkdir", "-p", "#{CREW_DEST_PREFIX}/pgsql/data"
      system "chmod", "700", "#{CREW_DEST_PREFIX}/pgsql/data"
    end
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-world"
    system "cp", "pgctl", "#{CREW_DEST_PREFIX}/bin"
  end

  def self.postinstall
    system "initdb -D #{CREW_PREFIX}/pgsql/data" unless File.exists? "#{CREW_PREFIX}/pgsql/data/PG_VERSION"
    puts
    puts "To start postgres: pgctl -l logfile start".lightblue
    puts "To stop postgres: pgctl stop".lightblue
    puts "Create a database: createdb <dbname>".lightblue
    puts "Connect to database: psql <dbname>".lightblue
    puts
  end
end
