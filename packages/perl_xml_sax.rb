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
    aarch64: '092f04aeea97bd4716b2ee0e640a996fa2db4c935fd4774a57d94e2d438f354a',
     armv7l: '092f04aeea97bd4716b2ee0e640a996fa2db4c935fd4774a57d94e2d438f354a',
       i686: 'a5d315916037c20b63159c312eb55a7c279ed53505339ba71e3f9e0544229ea9',
     x86_64: '4910b4873b7c471c80753ff576339eb2968515405885f20ea26efae60e32cc81'
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
