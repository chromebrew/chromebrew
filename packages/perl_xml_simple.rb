require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version "2.25-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '45d9d279c2ce198f51331db73941810f2c99d0c13a1ab4dbdc7537d07b2ede64',
     armv7l: '45d9d279c2ce198f51331db73941810f2c99d0c13a1ab4dbdc7537d07b2ede64',
       i686: 'a04f87b5c42c657cd189838afa67e10834099fa11036ec118bcd27d97dbfa6dc',
     x86_64: 'c8a5970d43559387e106b58d540d70fe1d24335323659ed6e9356d78f5dcd524'
  })

  depends_on 'perl_xml_parser' => :build

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
