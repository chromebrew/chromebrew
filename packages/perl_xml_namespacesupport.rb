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
    aarch64: '9c1b4c8f27912fd59f299a073cd2b5b5f8131d09ef03d326f13f645c4455a153',
     armv7l: '9c1b4c8f27912fd59f299a073cd2b5b5f8131d09ef03d326f13f645c4455a153',
       i686: '7bc1a19ad4ac840dbaae6650bcec0953f9a08d0805ccef1d5d1ebcf3ba707071',
     x86_64: '177ea475455fb7d9aa7611829edbdaf7d6ba43aba35e3815146899ccd6456dc5'
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
