require 'package'

class Percona_toolkit < Package
  description 'Percona Toolkit is a collection of advanced open source command-line tools, developed and used by the Percona technical staff, that are engineered to perform a variety of MySQL®, MongoB® and system tasks that are too difficult or complex to perform manually.'
  homepage 'https://www.percona.com/software/database-tools/percona-toolkit'
  version '3.0.7'
  compatibility 'all'
  source_url 'https://www.percona.com/downloads/percona-toolkit/3.0.7/source/tarball/percona-toolkit-3.0.7.tar.gz'
  source_sha256 '40f1a2241fb3ac1049e43ea75056f02d8af48c1eb731b48a4b564a054f8227e3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/percona_toolkit-3.0.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/percona_toolkit-3.0.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/percona_toolkit-3.0.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/percona_toolkit-3.0.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c805533b7b9ba184e17d070574c30c453a73a2dde3258787b50c6ac77e319495',
     armv7l: 'c805533b7b9ba184e17d070574c30c453a73a2dde3258787b50c6ac77e319495',
       i686: 'd71e086d9283cf638e461ec2d5917ddeeeda4ac0fb130a55cd86d436df5eb465',
     x86_64: 'b3820dd0791160369b84a66017c6938ee6850074b9e3efefa2a1b4c64380727b',
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
