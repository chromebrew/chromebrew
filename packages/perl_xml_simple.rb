require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version '2.25-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-3_armv7l/perl_xml_simple-2.25-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-3_armv7l/perl_xml_simple-2.25-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-3_i686/perl_xml_simple-2.25-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-3_x86_64/perl_xml_simple-2.25-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a3f24faeee658cd3f468e1f09b1a9c90774b00f8ebcf25eec5b1ec1ef275c213',
     armv7l: 'a3f24faeee658cd3f468e1f09b1a9c90774b00f8ebcf25eec5b1ec1ef275c213',
       i686: 'e27342b9bb17969c0ec3e5bd1ef71f1a55c8c59300ac00bcda54d1c12853ad50',
     x86_64: '3e412a9ffcccf45908cf651af554ba7cc89576753c0e9930d3f6f86cd18545c1'
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
