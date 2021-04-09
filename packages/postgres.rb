require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '9.6.16-1'
  license 'PostgreSQL and GPL-2'
  compatibility 'all'
  source_url 'https://ftp.postgresql.org/pub/source/v9.6.16/postgresql-9.6.16.tar.bz2'
  source_sha256 '5c6cba9cc0df70ba2b128c4a87d0babfce7c0e2b888f70a9c8485745f66b22e7'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/postgres-9.6.16-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6211702e02c1cd622ce2c5b27d72ef69136fe0b59e099a9360130224455281ba',
     armv7l: '6211702e02c1cd622ce2c5b27d72ef69136fe0b59e099a9360130224455281ba',
       i686: 'cd46d490470c4cd16d09f23f63b78ecd92bcb74739f19fee42eeb86ca70f563d',
     x86_64: 'ea73f2fb333ee217ae2adf184b54d300b5b856c0ad1848349f78fd46390e1932'
  })

  # Feel free to change this directory prior to compiling.

  # Future work: this directory isn't FHS compliant
  PGDATA = "#{CREW_PREFIX}/data/pgsql".freeze

  def self.build
    system "sed -i 's,PGDATA=\"/usr/local/pgsql/data\",PGDATA=\"#{PGDATA}\",' contrib/start-scripts/linux"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system 'make world'
  end

  def self.install
    # This conditional is needed for installation only.
    unless Dir.exist? PGDATA.to_s
      system 'mkdir', '-p', PGDATA.to_s
      system 'chmod', '700', PGDATA.to_s
    end
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-world'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @postgresenv = <<~POSTGRESEOF
      # PostgreSQL configuration
      export PGDATA="#{PGDATA}"
    POSTGRESEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/postgres", @postgresenv)
  end

  def self.postinstall
    # This conditional is needed for installation only.  If this package is updated in the future,
    # there is no need to initialize the data directory and display messages again.
    unless File.exist? "#{PGDATA}/PG_VERSION"
      system "initdb -D #{PGDATA}"
      puts
      puts 'To start postgres: pg_ctl -l logfile start'.lightblue
      puts 'To stop postgres: pg_ctl stop'.lightblue
      puts 'Create a database: createdb <dbname>'.lightblue
      puts 'Connect to database: psql <dbname>'.lightblue
      puts
    end
  end
end
