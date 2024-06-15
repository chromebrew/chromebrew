require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version '2.25-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9945ac5a1564a81c70fd0d3e59aa84164616e7ce638fe2ead1436cfdf9935c11',
     armv7l: '9945ac5a1564a81c70fd0d3e59aa84164616e7ce638fe2ead1436cfdf9935c11',
       i686: 'ea1c3c4b8331b4fbaf5e57353404301bc160df27e42d99e350291edd63f388cc',
     x86_64: '9f60918ddee247e80de73be7cc35ea93350ef2ae867d6bbcff00f1361125aaa2'
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
