require 'package'

class Perl_xml_namespacesupport < Package
  description 'XML::NamespaceSupport - A simple generic namespace processor'
  homepage 'https://metacpan.org/pod/XML::NamespaceSupport'
  version '1.12_9-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12_9.tar.gz'
  source_sha256 '2e84a057f0a8c845a612d212742cb94fca4fc8a433150b5721bd448f77d1e4a9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1772900d761a750578241e2ce5e3dccc27829d1f9aee1395bb7763bf4c03b7a',
     armv7l: 'b1772900d761a750578241e2ce5e3dccc27829d1f9aee1395bb7763bf4c03b7a',
       i686: '9cce306d072bf96b34ba125e0858078314275ac295b7d2033600dbaa61b7cd92',
     x86_64: '6218a18737bb516f4c237082aba6d6e295a309ee7cda6bbacd8b0186d8dc8a51'
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
