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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-perl5.36_i686/perl_xml_simple-2.25-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-perl5.36_x86_64/perl_xml_simple-2.25-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '5e54ff30d6de83b364781d6c1644ad631eac5ef00c2686f9407a2c8f64bc8542',
  x86_64: 'c9177b56ce48f24f6950b4826e9c49491b9bd08aecf686099c1ba9480fd4bb10'
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
