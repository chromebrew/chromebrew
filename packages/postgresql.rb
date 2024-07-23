require 'package'

class Postgresql < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org'
  version '16.2'
  license 'PostgreSQL and GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.postgresql.org/pub/source/v16.2/postgresql-16.2.tar.bz2'
  source_sha256 '446e88294dbc2c9085ab4b7061a646fa604b4bec03521d5ea671c2e5ad9b2952'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14db30417e4b2ce3ccdef5ab1db9cab35ea40ef791b2e7f8d4c0f606b927a5c2',
     armv7l: '14db30417e4b2ce3ccdef5ab1db9cab35ea40ef791b2e7f8d4c0f606b927a5c2',
     x86_64: '7e61c80eeea5c1a7367d46ec04bfad0f91ee8e122931317b2c7c88d75358c14b'
  })

  depends_on 'brotli' => :build
  depends_on 'expat' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' => :build
  depends_on 'libxml2' # R
  depends_on 'linux_pam' # R
  depends_on 'llvm18_dev' => :build
  depends_on 'llvm18_lib' # R
  depends_on 'lz4' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'perl' # R
  depends_on 'python3' # R
  depends_on 'readline' # R
  depends_on 'tcl' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  print_source_bashrc

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
