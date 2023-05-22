require 'package'

class Perl_xml_parser < Package
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.46-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz'
  source_sha256 'd331332491c51cccfb4cb94ffc44f9cd73378e618498d4a37df9e043661c515d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.36_armv7l/perl_xml_parser-2.46-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.36_armv7l/perl_xml_parser-2.46-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.36_i686/perl_xml_parser-2.46-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.36_x86_64/perl_xml_parser-2.46-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5952c08c7d108d4e9c98bf0f8ea4f95a7886b108b72b8c2b0ad3b0e346638d08',
     armv7l: '5952c08c7d108d4e9c98bf0f8ea4f95a7886b108b72b8c2b0ad3b0e346638d08',
       i686: '277aac0829127c7f5db23c670004f12ecbc9073500c8f63b3301b23cd3f22a7a',
     x86_64: 'ae4a10a4f2995780f20fba169c39281c471a495e5b394aef21a4754870df9045'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R
  conflicts_ok # conflicts with perl_date_format

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
