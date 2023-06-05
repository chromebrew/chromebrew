require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '15.3'
  license 'PostgreSQL and GPL-2'
  compatibility 'all'
  source_url 'https://ftp.postgresql.org/pub/source/v15.3/postgresql-15.3.tar.bz2'
  source_sha256 'ffc7d4891f00ffbf5c3f4eab7fbbced8460b8c0ee63c5a5167133b9e6599d932'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/15.3_armv7l/postgres-15.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/15.3_armv7l/postgres-15.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/15.3_i686/postgres-15.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/postgres/15.3_x86_64/postgres-15.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b405cde3037b87a93a730bbcb60b83ce0bca8de039abd6efb4c619caba420785',
     armv7l: 'b405cde3037b87a93a730bbcb60b83ce0bca8de039abd6efb4c619caba420785',
       i686: 'b19e9500521024d5ad34d92012424f82649d55005e43ba6a82f509a0d05d80f3',
     x86_64: '082fa193fcdab42cd484388111cc1dc841c0e403df069e76b600015cfc996d92'
  })

  depends_on 'brotli'
  depends_on 'expat'
  depends_on 'icu4c'
  depends_on 'krb5'
  depends_on 'libcyrussasl'
  depends_on 'libxml2'
  depends_on 'linux_pam'
  depends_on 'llvm_lib16'
  depends_on 'lz4'
  depends_on 'openldap'
  depends_on 'perl'
  depends_on 'python3'
  depends_on 'tcl'
  depends_on 'zstd'

  no_fhs

  # Feel free to change this directory prior to compiling.

  # Future work: this directory isn't FHS compliant
  PGDATA = "#{CREW_PREFIX}/pgsql/data".freeze

  def self.build
    system "sed -i 's,PGDATA=\"/usr/local/pgsql/data\",PGDATA=\"#{PGDATA}\",' contrib/start-scripts/linux"
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
        FileUtils.rm_rf "#{CREW_PREFIX}/pgsql"
        puts "#{PGDATA} removed.".lightred
      else
        puts "#{PGDATA} saved.".lightgreen
      end
    end
  end
end
