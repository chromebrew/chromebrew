require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version '20211001'
  license 'GPL2'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/A/AB/ABH/Mozilla-CA-20211001.tar.gz"
  source_sha256 '122c8900000a9d388aa8e44f911cab6c118fe8497417917a84a8ec183971b449'

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
