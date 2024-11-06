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
    aarch64: '0351cf2aa40bb96a716b2817b2b6ec34fac6dd650fc34e643648744c668dbd99',
     armv7l: '0351cf2aa40bb96a716b2817b2b6ec34fac6dd650fc34e643648744c668dbd99',
       i686: '3577e10088cf4d5d8761a360520ac4dc4f22f6da0112735b2fc37725b3d6a618',
     x86_64: '4f198de557843ed2102fe0b324ee3d83e83f41c7c7e6cb7700a7e55778354e0d'
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
