require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '10.17'
  license 'PostgreSQL and GPL-2'
  compatibility 'all'
  source_url 'https://ftp.postgresql.org/pub/source/v10.17/postgresql-10.17.tar.bz2'
  source_sha256 '5af28071606c9cd82212c19ba584657a9d240e1c4c2da28fc1f3998a2754b26c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/10.17_armv7l/postgres-10.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/10.17_armv7l/postgres-10.17-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/10.17_i686/postgres-10.17-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/10.17_x86_64/postgres-10.17-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '67ec0a8d3aa3fa72a86a6041d74cf17ba16919e373127f19c50b88518d830a08',
     armv7l: '67ec0a8d3aa3fa72a86a6041d74cf17ba16919e373127f19c50b88518d830a08',
       i686: '0e6b22d4eaab62bfd4eac9586569d8d28b842e2386af2a03374887a6edf8d384',
     x86_64: '60acfd4374380012bce2cda3d6e2df788f340c180fb725f5166a46c48932a17f'
  })

  # Feel free to change this directory prior to compiling.

  # Future work: this directory isn't FHS compliant
  PGDATA = "#{CREW_PREFIX}/pgsql/data".freeze

  def self.build
    system "sed -i 's,PGDATA=\"/usr/local/pgsql/data\",PGDATA=\"#{PGDATA}\",' contrib/start-scripts/linux"
    system "./configure #{CREW_OPTIONS}"
    system 'make world'
  end

  def self.install
    # This conditional is needed for installation only.
    unless Dir.exist? PGDATA
      FileUtils.mkdir_p PGDATA
      FileUtils.chmod 0o700, PGDATA
    end
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-world'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @postgresenv = <<~POSTGRESEOF
      # PostgreSQL configuration
      export PGDATA="#{PGDATA}"
      # Start server on login
      #if [ -f #{CREW_PREFIX}/bin/pg_ctl ]; then
      #  pg_ctl -l #{CREW_PREFIX}/tmp/pgsql.log start
      #fi
    POSTGRESEOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/postgres", @postgresenv)
  end

  def self.postinstall
    # This conditional is needed for installation only.  If this package is updated in the future,
    # there is no need to initialize the data directory and display messages again.
    system "initdb -D #{PGDATA}" unless File.exist? "#{PGDATA}/PG_VERSION"
    puts
    puts 'To complete the installation, execute the following:'.lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
    puts 'To start postgres: pg_ctl -l logfile start'.lightblue
    puts 'To stop postgres: pg_ctl stop'.lightblue
    puts 'Create a database: createdb <dbname>'.lightblue
    puts 'Connect to database: psql <dbname>'.lightblue
    puts
    puts "To configure, edit #{CREW_DEST_PREFIX}/etc/env.d/postgres".lightblue
    puts "Remember to 'source ~/.bashrc' after changes".lightblue
    puts
  end

  def self.remove
    if Dir.exist? PGDATA
      puts 'WARNING: This will delete all databases!'.orange
      print "Would you like to remove #{PGDATA}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf PGDATA
        FileUtils.rm_rf "#{CREW_PREFIX}/pgsql"
        puts "#{PGDATA} removed.".lightred
      else
        puts "#{PGDATA} saved.".lightgreen
      end
    end
  end
end
