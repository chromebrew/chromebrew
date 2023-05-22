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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09_armv7l/perl_xml_sax_base-1.09-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09_armv7l/perl_xml_sax_base-1.09-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09_i686/perl_xml_sax_base-1.09-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax_base/1.09_x86_64/perl_xml_sax_base-1.09-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '09a89d696a4606e9c11547883a5e7e14ff016c39df71f3cd85780844b1ca7210',
     armv7l: '09a89d696a4606e9c11547883a5e7e14ff016c39df71f3cd85780844b1ca7210',
       i686: '247313834036ebfadbec0ea6830057a290fba8cd605adc276bd21eadaf2995bc',
     x86_64: '37934d05df2097c8d6e19795a2054ea8fa0dd0b9eeb2e129d6ce14b1c37b0d16'
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
