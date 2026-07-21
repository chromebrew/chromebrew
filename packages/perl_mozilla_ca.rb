require 'package'

class Perl_mozilla_ca < Package
  description "Mozilla::CA - Mozilla's CA cert bundle in PEM format"
  homepage 'https://metacpan.org/pod/Mozilla::CA'
  version "20250602-#{CREW_PERL_VER}"
  license 'GPL2'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/L/LW/LWP/Mozilla-CA-#{version.split('-')[0]}.tar.gz"
  source_sha256 'adeac0752440b2da094e8036bab6c857e22172457658868f5ac364f0c7b35481'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c077ea1082d8158a93a5ffe663845f9e1e3ccf0015b63da9d6c23c8be3cde5d0',
     armv7l: 'c077ea1082d8158a93a5ffe663845f9e1e3ccf0015b63da9d6c23c8be3cde5d0',
       i686: 'fb0c48f487430d75df6130938c460cb41f9c01bbe1d1397a33bc4e786eadbfec',
     x86_64: 'aed6533cc53837013125855d9695182d30a90579eab2b23d660c5b72be8cde0b'
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
