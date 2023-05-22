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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-perl5.36_armv7l/perl_xml_simple-2.25-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-perl5.36_armv7l/perl_xml_simple-2.25-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-perl5.36_i686/perl_xml_simple-2.25-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-perl5.36_x86_64/perl_xml_simple-2.25-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '410ccdb5826bcb467594300ff1cdceeb44646f506ae325b75d077c1351fd3fc2',
     armv7l: '410ccdb5826bcb467594300ff1cdceeb44646f506ae325b75d077c1351fd3fc2',
       i686: '45dae7fafa2b946f59c18ebb62e7cdd760ccfe1a6ef2b73f8381d2b50a05d64a',
     x86_64: '28e2460023ca11cd1c496a4a411ada0f3bce447aaa18a776a14f34d736a28997'
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
