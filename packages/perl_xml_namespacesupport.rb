require 'package'

class Perl_xml_namespacesupport < Package
  description 'XML::NamespaceSupport - A simple generic namespace processor'
  homepage 'https://metacpan.org/pod/XML::NamespaceSupport'
  version "1.12_9-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12_9.tar.gz'
  source_sha256 '2e84a057f0a8c845a612d212742cb94fca4fc8a433150b5721bd448f77d1e4a9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'caa92af0877ffce3a53820051d4d13f8fa5d5dd36e946a4f6497733bfff3ea4f',
     armv7l: 'caa92af0877ffce3a53820051d4d13f8fa5d5dd36e946a4f6497733bfff3ea4f',
       i686: '60c3d09ae463a4f1acb55e756ffc350a78e56cde80eee9359a331a2eac7a20dc',
     x86_64: '04d51307f32fdad25dc319fbc05176a387e7b680f766b07eee346721a1c861a4'
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
