require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '16.0'
  license 'PostgreSQL and GPL-2'
  compatibility 'all'
  source_url 'https://ftp.postgresql.org/pub/source/v16.0/postgresql-16.0.tar.bz2'
  source_sha256 'df9e823eb22330444e1d48e52cc65135a652a6fdb3ce325e3f08549339f51b99'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/16.0_armv7l/postgres-16.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/16.0_armv7l/postgres-16.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/16.0_i686/postgres-16.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/16.0_x86_64/postgres-16.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8afed5edc4f2a481063478cf88ddbb4f3d7e1624a7490316d159f33598fde425',
     armv7l: '8afed5edc4f2a481063478cf88ddbb4f3d7e1624a7490316d159f33598fde425',
       i686: 'bdaeb4c338f81ccb5f0bb7df6c9a54e12e8d855bb365f6adcfd21fcfe6eb06bd',
     x86_64: 'ec76b05bcfc8cdb797563ec2695073f31fee64c6574e4e8cbfc5aa9272694e2f'
  })

  depends_on 'brotli'
  depends_on 'expat'
  depends_on 'icu4c'
  depends_on 'krb5'
  depends_on 'libcyrussasl'
  depends_on 'libxml2'
  depends_on 'linux_pam'
  depends_on 'llvm17_dev' => :build
  depends_on 'llvm16_lib'
  depends_on 'lz4'
  depends_on 'openldap'
  depends_on 'perl'
  depends_on 'python3'
  depends_on 'tcl'
  depends_on 'zstd'

  PGDATA = "#{CREW_PREFIX}/share/pgsql/data".freeze

  def self.patch
    system "sed -i 's,PGDATA=\"/usr/local/pgsql/data\",PGDATA=\"#{PGDATA}\",' contrib/start-scripts/linux"
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --with-gssapi \
      --with-icu \
      --with-ldap \
      --with-libxml \
      --with-llvm \
      --with-lz4 \
      --with-openssl \
      --with-pam \
      --with-perl \
      --with-python \
      --with-tcl \
      --with-zstd"
    system 'make world'
  end

  def self.install
    # This conditional is needed for installation only.
    unless Dir.exist? PGDATA
      FileUtils.mkdir_p PGDATA
      FileUtils.chmod 0o700, PGDATA
    end
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-world'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/var/log/"
    FileUtils.touch "#{CREW_DEST_PREFIX}/var/log/pgsql.log"

    File.write 'postgresenv', <<~POSTGRESEOF
      # PostgreSQL configuration
      export PGDATA="#{PGDATA}"
      # Start server on login
      if [ -x #{CREW_PREFIX}/bin/pg_ctl ]; then
        pg_ctl -l #{CREW_PREFIX}/var/log/pgsql.log start
      fi
    POSTGRESEOF
    FileUtils.install 'postgresenv', "#{CREW_DEST_PREFIX}/etc/env.d/postgres", mode: 0o644
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
    puts
    puts 'Create a database: createdb <dbname>'.lightblue
    puts 'Connect to database: psql <dbname>'.lightblue
    puts
    puts "To configure, edit #{CREW_PREFIX}/etc/env.d/postgres".lightblue
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
        FileUtils.rm_rf "#{CREW_PREFIX}/share/pgsql"
        puts "#{PGDATA} removed.".lightred
      else
        puts "#{PGDATA} saved.".lightgreen
      end
    end
  end
end
