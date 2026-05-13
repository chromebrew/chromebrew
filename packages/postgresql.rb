require 'buildsystems/meson'

class Postgresql < Meson
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org'
  version "18.3-#{CREW_ICU_VER}"
  license 'PostgreSQL and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftp.postgresql.org/pub/source/v#{version.split('-').first}/postgresql-#{version.split('-').first}.tar.bz2"
  source_sha256 'd95663fbbf3a80f81a9d98d895266bdcb74ba274bcc04ef6d76630a72dee016f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8ec04a108bdebc062746e275879f4f069b7943cf095fe17e4dd976197226e98',
     armv7l: 'f8ec04a108bdebc062746e275879f4f069b7943cf095fe17e4dd976197226e98',
     x86_64: '26f22b65c13c6b5a6a74d8c8f2864fbe7b30562569c6a24c4548adb13b149218'
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
