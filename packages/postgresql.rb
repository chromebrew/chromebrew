require 'buildsystems/meson'

class Postgresql < Meson
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org'
  version "17.5-#{CREW_ICU_VER}"
  license 'PostgreSQL and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftp.postgresql.org/pub/source/v#{version.split('-').first}/postgresql-#{version.split('-').first}.tar.bz2"
  source_sha256 'c4605b73fea11963406699f949b966e5d173a7ee0ccaef8938dec0ca8a995fe7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df11f2fcacc087b35ed37dab01c8b1035116416a963f59bf6d8b12c6fc13516b',
     armv7l: 'df11f2fcacc087b35ed37dab01c8b1035116416a963f59bf6d8b12c6fc13516b',
     x86_64: '4eabbe698a651a0db078b49b0083bd57096da75aae600709fd6bde04c8193c93'
  })

  depends_on 'brotli' => :build
  depends_on 'docbook_xml45' => :build
  depends_on 'expat' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'krb5' # R
  depends_on 'libcyrussasl' => :build
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'linux_pam' # R
  depends_on 'llvm20_dev' => :build
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

  meson_install_extras do
    # This conditional is needed for installation only.
    unless Dir.exist? PGDATA
      FileUtils.mkdir_p PGDATA
      FileUtils.chmod 0o700, PGDATA
    end

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
    ExitMessage.add <<~EOM

      To start postgres: pg_ctl -l logfile start
      To stop postgres: pg_ctl stop

      Create a database: createdb <dbname>
      Connect to database: psql <dbname>

      To configure, edit #{CREW_PREFIX}/etc/env.d/postgres
    EOM
  end

  def self.postremove
    puts 'WARNING: This will delete all databases!'.orange
    Package.agree_to_remove(PGDATA)
  end
end
