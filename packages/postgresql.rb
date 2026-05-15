require 'buildsystems/meson'

class Postgresql < Meson
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org'
  version "18.4-#{CREW_ICU_VER}"
  license 'PostgreSQL and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftp.postgresql.org/pub/source/v#{version.split('-').first}/postgresql-#{version.split('-').first}.tar.bz2"
  source_sha256 '81a81ec695fb0c7901407defaa1d2f7973617154cf27ba74e3a7ab8e64436094'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e26d3d2b33fb86d939295a6e40aaa6166d2b4058aa1499ada914f742af8d27a2',
     armv7l: 'e26d3d2b33fb86d939295a6e40aaa6166d2b4058aa1499ada914f742af8d27a2',
     x86_64: '02d866fa34ded9e26f7a263d87fcf6e2c242e56de3d21783da707a2fd4f4aeb2'
  })

  depends_on 'brotli' => :build
  depends_on 'curl' => :library
  depends_on 'docbook_xml45' => :build
  depends_on 'expat' => :build
  depends_on 'fop' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :executable
  depends_on 'krb5' => :library
  depends_on 'libcyrussasl' => :build
  depends_on 'liburing' => :executable
  depends_on 'libxml2' => :library
  depends_on 'libxslt' => :library
  depends_on 'linux_pam' => :executable
  depends_on 'llvm_dev' => :build
  depends_on 'lz4' => :executable
  depends_on 'numactl' => :executable
  depends_on 'openldap' => :library
  depends_on 'openssl' => :library
  depends_on 'pandoc' => :build
  depends_on 'perl' => :library
  depends_on 'python3' => :library
  depends_on 'readline' => :executable
  depends_on 'tcl' # R
  depends_on 'wget2' # R
  depends_on 'zlib' => :library
  depends_on 'zstd' => :executable

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
