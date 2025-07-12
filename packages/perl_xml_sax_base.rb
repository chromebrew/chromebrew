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
    aarch64: 'fc9a06e69d8635106d60b763906eb7dd0ad660ee3a68439d7deafd02a55ab28b',
     armv7l: 'fc9a06e69d8635106d60b763906eb7dd0ad660ee3a68439d7deafd02a55ab28b',
       i686: '1f25e4c5454db620193cb3d0643670f05c024551327871fc0fb33fa54c16ffc4',
     x86_64: '247aba418d9bbfca8048deafd258380ae9dfdc4401e19692a3784985b27fcdb8'
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
