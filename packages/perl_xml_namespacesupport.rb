require 'package'

class Perl_xml_namespacesupport < Package
  description 'XML::NamespaceSupport - A simple generic namespace processor'
  homepage 'https://metacpan.org/pod/XML::NamespaceSupport'
  version '1.12-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz'
  source_sha256 '47e995859f8dd0413aa3f22d350c4a62da652e854267aa0586ae544ae2bae5ef'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12_armv7l/perl_xml_namespacesupport-1.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12_armv7l/perl_xml_namespacesupport-1.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12_i686/perl_xml_namespacesupport-1.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12_x86_64/perl_xml_namespacesupport-1.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f2aa35ec8928eaa44e36faa97cfb8159a74c678f27dc9c4552a67a0268a6effe',
     armv7l: 'f2aa35ec8928eaa44e36faa97cfb8159a74c678f27dc9c4552a67a0268a6effe',
       i686: 'd9ed95a088dee03433450150a53d3a734255fb50ccbc6ec1341001280ed07c09',
     x86_64: '5a7709014959928cfc89c3d9755d8c31e3243e37579b4e8dd94661e9a49166bc'
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
