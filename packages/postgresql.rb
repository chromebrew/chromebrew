require 'package'

class Postgresql < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org'
  version '16.4-icu75.1'
  license 'PostgreSQL and GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://ftp.postgresql.org/pub/source/v#{version.split('-').first}/postgresql-#{version.split('-').first}.tar.bz2"
  source_sha256 '971766d645aa73e93b9ef4e3be44201b4f45b5477095b049125403f9f3386d6f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd9f2e0d26ca6e2a67af92d5486216342b86e896d6853f9a528297f52824cdb5',
     armv7l: 'dd9f2e0d26ca6e2a67af92d5486216342b86e896d6853f9a528297f52824cdb5',
     x86_64: 'd90d4059bb2a6d1b128e80aeb5ead326d3f2ffa3bcaca00a5a12c8bea80071d0'
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
  depends_on 'zlib' # R
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

  def self.postremove
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
