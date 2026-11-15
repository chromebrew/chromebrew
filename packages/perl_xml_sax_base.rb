require 'package'

class Perl_xml_sax_base < Package
  description 'XML::SAX - Simple API for XML'
  homepage 'https://metacpan.org/pod/XML::SAX'
  version "1.09-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz'
  source_sha256 '66cb355ba4ef47c10ca738bd35999723644386ac853abbeb5132841f5e8a2ad0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4beafcafd1c1426567674cc3dd816f9f84fb2ba4c0e3e43718e5ba50fcfdaff9',
     armv7l: '4beafcafd1c1426567674cc3dd816f9f84fb2ba4c0e3e43718e5ba50fcfdaff9',
       i686: '9a83d58e4de4c25102eb9a1f191572efb0dab34493570e681b25cc52c55041ad',
     x86_64: 'e0b7e44ada5732a07a94076954ff76429159fcbb1dcfd271b13aa4ebfe107c05'
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
