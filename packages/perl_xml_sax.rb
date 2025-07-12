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
    aarch64: '3219b35ffa3fc368abe82e2c988f495c7383769df34965d92df993567c6075cb',
     armv7l: '3219b35ffa3fc368abe82e2c988f495c7383769df34965d92df993567c6075cb',
       i686: '5e2544c16d5fd3f5614e78a32e9ba8268eafbe83ee38fb2aea9a30024b6e35e6',
     x86_64: 'f8084fd90464049f82f3acec3ba40b013a646c33fc264208ecc9bb0013301d13'
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
