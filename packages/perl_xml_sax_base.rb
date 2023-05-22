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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.36_armv7l/perl_xml_sax_base-1.09-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.36_armv7l/perl_xml_sax_base-1.09-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.36_i686/perl_xml_sax_base-1.09-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09-perl5.36_x86_64/perl_xml_sax_base-1.09-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '19065ce765f1723ffad7072757e3b6b6a0a4ee04d32dadc731d505bb106a49ec',
     armv7l: '19065ce765f1723ffad7072757e3b6b6a0a4ee04d32dadc731d505bb106a49ec',
       i686: '9922191e3fdb09d497610f0b27715407d902bc1b5ca5e55ad4f70e4bc5b86d7c',
     x86_64: 'a21d2b0f607998103b51732272c286c48439f2eab8d084aea8636f1ad7bbbd9c'
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
