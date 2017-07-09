require 'package'

class Postgres < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '9.5.0'
  source_url 'https://ftp.postgresql.org/pub/source/v9.5.0/postgresql-9.5.0.tar.bz2'
  source_sha256 'f1c0d3a1a8aa8c92738cab0153fbfffcc4d4158b3fee84f7aa6bfea8283978bc'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/postgres-9.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/postgres-9.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/postgres-9.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/postgres-9.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '455a13824825618b672d5d7707c9b2f54b267cf62e97a6af4e8f5aa735dd0d9b',
     armv7l: '455a13824825618b672d5d7707c9b2f54b267cf62e97a6af4e8f5aa735dd0d9b',
       i686: 'aa007ee10e7649e6ba71efcb22dcf9d925146b4719e1885b0926b4f0a9d20ae1',
     x86_64: '4f81a4206fb7251a1b7a19ea537b44124faa32519385fc8f43fc1afb88524797',
  })

  depends_on 'buildessential'
  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system "./configure"
    system "make world"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-world"
    out = "#{CREW_DEST_DIR}/usr/local/pgsql/data"
    system "mkdir", out
    puts "------------------"
    puts "Installation success!"
    puts "To get started, you need to initialize a database directory"
    puts "'echo \"export PATH=/usr/local/pgsql/bin:$PATH\" >> ~/.bashrc'"
    puts "'source ~/.bashrc'"
    puts "'chmod 700 /usr/local/pgsql/data'"
    puts "'initdb -D /usr/local/pgsql/data'"
    puts "To start postgres: 'pg_ctl -D /usr/local/pgsql/data -l logfile start'"
    puts "To stop postgres: 'pg_ctl -D /usr/local/pgsql/data stop'"
    puts "Create a database: 'createdb <dbname>'"
    puts "Connect to database: 'psql <dbname>'"
  end
end
