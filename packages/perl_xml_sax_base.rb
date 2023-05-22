require 'package'

class Perl_xml_sax_base < Package
  description 'XML::SAX - Simple API for XML'
  homepage 'https://metacpan.org/pod/XML::SAX'
  version '1.09-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz'
  source_sha256 '66cb355ba4ef47c10ca738bd35999723644386ac853abbeb5132841f5e8a2ad0'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.36_i686/perl_xml_sax_base-1.09-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.36_x86_64/perl_xml_sax_base-1.09-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: '01527d1c969d0a0d2da9c8c610a89993fb26dd31b4915542211f96a22b8b1064',
  x86_64: 'd7874ad4ff5c466312b8bb162e3ab199779b724d8cdccfd5352e0b997b202df2'
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
