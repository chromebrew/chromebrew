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
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.36_i686/perl_xml_namespacesupport-1.12-perl5.36-chromeos-i686.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_namespacesupport/1.12-perl5.36_x86_64/perl_xml_namespacesupport-1.12-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'f7a52cdf205c06750f98dfdc12313b0b7203b16b7723c2747484e32a2ff8080d',
  x86_64: '95c419c127e5ae024abd74686204d5c98054d3049eb44737f7b2b75fb6563f7b'
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
