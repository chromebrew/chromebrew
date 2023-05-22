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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.36_armv7l/perl_xml_namespacesupport-1.12-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.36_armv7l/perl_xml_namespacesupport-1.12-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.36_i686/perl_xml_namespacesupport-1.12-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.36_x86_64/perl_xml_namespacesupport-1.12-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cfc1507f6cf781a8ef787a668495bc80fbb2c32150e045a9b7c466a97ea80aa2',
     armv7l: 'cfc1507f6cf781a8ef787a668495bc80fbb2c32150e045a9b7c466a97ea80aa2',
       i686: '506ce36b061a45cb8d5ac6c7d807cac797446c628946a4a264d358e55f57498c',
     x86_64: 'cd611c8f4c18c9293c4dcefa890648f6adf2d13ab4bf6128c7f974de04e29f16'
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
