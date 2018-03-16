require 'package'

class Percona_toolkit < Package
  description 'Percona Toolkit is a collection of advanced open source command-line tools, developed and used by the Percona technical staff, that are engineered to perform a variety of MySQL®, MongoB® and system tasks that are too difficult or complex to perform manually.'
  homepage 'https://www.percona.com/software/database-tools/percona-toolkit'
  version '3.0.7'
  source_url 'https://www.percona.com/downloads/percona-toolkit/3.0.7/source/tarball/percona-toolkit-3.0.7.tar.gz'
  source_sha256 '40f1a2241fb3ac1049e43ea75056f02d8af48c1eb731b48a4b564a054f8227e3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'percona_server'
  depends_on 'perl' => :build

  def self.build
    system "perl Makefile.PL PREFIX=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
