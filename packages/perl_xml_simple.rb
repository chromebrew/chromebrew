require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version "2.25-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9793837b18dbebd5b0c429ca557a21bc44bd1d4b394f242338c03c9c90d1ab0',
     armv7l: 'd9793837b18dbebd5b0c429ca557a21bc44bd1d4b394f242338c03c9c90d1ab0',
       i686: '2973a81d4780f83ed7a3b3cd194e1a4124e749aa175d575bc7d7d74e4f2728e6',
     x86_64: 'd973217761c4a87609832b3bd8d2d462aab6a59c8d0dc33a15d7182b90f986c8'
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
