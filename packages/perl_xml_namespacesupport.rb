require 'package'

class Perl_xml_namespacesupport < Package
  description 'XML::NamespaceSupport - A simple generic namespace processor'
  homepage 'https://metacpan.org/pod/XML::NamespaceSupport'
  version '1.12-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz'
  source_sha256 '47e995859f8dd0413aa3f22d350c4a62da652e854267aa0586ae544ae2bae5ef'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.38_armv7l/perl_xml_namespacesupport-1.12-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.38_armv7l/perl_xml_namespacesupport-1.12-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.38_i686/perl_xml_namespacesupport-1.12-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.38_x86_64/perl_xml_namespacesupport-1.12-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e05f662627afe9119e329ab6a88c9da13927689df14c402a9cb68a2af67e692a',
     armv7l: 'e05f662627afe9119e329ab6a88c9da13927689df14c402a9cb68a2af67e692a',
       i686: 'e7b117d48f44261ed80dfdefc9dad8c28575e62b0645c9c1682852406d17f4f3',
     x86_64: '280a80101c32dc15389a999bb4e22cdc0b570dda75ac7d18c312387b93049723'
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
