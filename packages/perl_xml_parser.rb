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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-2_armv7l/perl_xml_parser-2.46-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-2_armv7l/perl_xml_parser-2.46-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-2_i686/perl_xml_parser-2.46-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-2_x86_64/perl_xml_parser-2.46-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54c7e396349f8da1269d3c4f77299c1a9a401dd337dd7cdc2523e868e075c69f',
     armv7l: '54c7e396349f8da1269d3c4f77299c1a9a401dd337dd7cdc2523e868e075c69f',
       i686: '9f0efeb52efc43f2a14301a0ebe8198bb8a2f3d2c9e8a420d791ae91c0691061',
     x86_64: '97451760fa4ddf1320025a4bba9d0b34ff3a5385befde7857a14b90d2b810cb3'
  })

  depends_on 'expat'
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
