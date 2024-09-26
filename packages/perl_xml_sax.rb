require 'package'

class Perl_xml_sax < Package
  description 'XML::SAX - Simple API for XML'
  homepage 'https://metacpan.org/pod/XML::SAX'
  version "1.02-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-1.02.tar.gz'
  source_sha256 '4506c387043aa6a77b455f00f57409f3720aa7e553495ab2535263b4ed1ea12a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dbddbf67a7c9ea789ca6eff91979bda6a134a925cb0e1d2285c83fde25f9aa10',
     armv7l: 'dbddbf67a7c9ea789ca6eff91979bda6a134a925cb0e1d2285c83fde25f9aa10',
       i686: '3994c3bf14ffb7ae3ef99e5e8678a648219b7984297609ea701327f8ded052ce',
     x86_64: 'e3547948c85de5c36899160dc4e9f1fce54ac5fd8f617636dbe7a064060e876d'
  })

  depends_on 'perl_xml_sax_base' => :build
  depends_on 'perl_xml_namespacesupport' => :build

  def self.prebuild
    system 'perl', 'Makefile.PL'
    system "sed -i 's,/usr/local,#{CREW_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install_perl'
  end
end
