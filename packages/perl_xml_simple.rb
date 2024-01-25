require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version '2.25-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a9fd6e9a24027772a04f6ed9fec7c1fb1643839768e855e99fd0ce7132f4979',
     armv7l: '0a9fd6e9a24027772a04f6ed9fec7c1fb1643839768e855e99fd0ce7132f4979',
       i686: '073c65f1ca5c5dc44d51e3b8ebcd254eb2f9c4bf5545e80f7db7609a5226690e',
     x86_64: '511f5fdc7c1acd82b0c960dd159fd6d44aa1d34aa53c30a53d086519c4a57e4d'
  })

  depends_on 'perl_xml_parser' => :build

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
