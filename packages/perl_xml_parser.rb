require 'package'

class Perl_xml_parser < Package
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.46-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz'
  source_sha256 'd331332491c51cccfb4cb94ffc44f9cd73378e618498d4a37df9e043661c515d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38_armv7l/perl_xml_parser-2.46-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38_armv7l/perl_xml_parser-2.46-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38_i686/perl_xml_parser-2.46-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46-perl5.38_x86_64/perl_xml_parser-2.46-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '303aef4332505beafeed08597e20a3d9b503a30f536dd52cc716a77fdf08beb8',
     armv7l: '303aef4332505beafeed08597e20a3d9b503a30f536dd52cc716a77fdf08beb8',
       i686: '0b3a7fabfa96ac44dce380b8e2c22107832caddf0bf67c8e9ee0535ed9d7aa3a',
     x86_64: 'c9986fa03bdeb3cccd6eb51ceefc5da14a2b78b5cf94aef3bc8ce7de7e33653b'
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
