require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version "20221114-#{CREW_PERL_VER}"
  license 'GPL2'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/H/HA/HAARG/Mozilla-CA-20221114.tar.gz'
  source_sha256 '701bea67be670add5a102f9f8c879402b4983096b1cb0e20dd47d52d7a10666b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3484f9a0f64d1aa583e03bbb08d21697e4e120d4fb649ec5dd2650401d21228b',
     armv7l: '3484f9a0f64d1aa583e03bbb08d21697e4e120d4fb649ec5dd2650401d21228b',
       i686: 'e042ac8a5558913be55df3b0444b33443b8f12c2d5ce10949e491fe4633554e5',
     x86_64: '55fc94a79a03820911dcd7185752b264bc9df6e1f13ca20ed66229bc8202d910'
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
