require 'package'

class Perl_xml_sax_base < Package
  description 'XML::SAX - Simple API for XML'
  homepage 'https://metacpan.org/pod/XML::SAX'
  version '1.09-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz'
  source_sha256 '66cb355ba4ef47c10ca738bd35999723644386ac853abbeb5132841f5e8a2ad0'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.38_armv7l/perl_xml_sax_base-1.09-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.38_armv7l/perl_xml_sax_base-1.09-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.38_i686/perl_xml_sax_base-1.09-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.38_x86_64/perl_xml_sax_base-1.09-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '34d6dbaf878b083e623a523cb7a525405ea194a836cc5ca449c9f940de79ddd2',
     armv7l: '34d6dbaf878b083e623a523cb7a525405ea194a836cc5ca449c9f940de79ddd2',
       i686: '044fcc8aa33ca005865509156b121d01b0f54d8f93cbab4f99428f8f71030891',
     x86_64: '67316a0d090248dee533f82fbd435d1160e1ac7706165364768e3268824b1414'
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
