require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version "20261020-#{CREW_PERL_VER}"
  license 'GPL2'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/L/LW/LWP/Mozilla-CA-#{version.split('-')[0]}.tar.gz"
  source_sha256 '1aeed97a463389e582e085e82de03ae0bffae74d46cf8ee4c511341e5508c21d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bbf663bbe898c00d8cf8b580dee13f43fb8b327b68edf0b9a149c3d7e662abc',
     armv7l: '5bbf663bbe898c00d8cf8b580dee13f43fb8b327b68edf0b9a149c3d7e662abc',
       i686: 'da261db25d230c539d7292093dd0fbc9c91b6b9b5e1545dbfa44f36d2c48eac0',
     x86_64: 'cdfaedb0f3ce31ebfb4e24931b79d62767a53ff969a4e5a501ca0662db16898d'
  })

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
