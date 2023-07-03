require 'package'

class Perl_xml_sax < Package
  description 'XML::SAX - Simple API for XML'
  homepage 'https://metacpan.org/pod/XML::SAX'
  version '1.02-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-1.02.tar.gz'
  source_sha256 '4506c387043aa6a77b455f00f57409f3720aa7e553495ab2535263b4ed1ea12a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.38_armv7l/perl_xml_sax-1.02-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.38_armv7l/perl_xml_sax-1.02-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.38_i686/perl_xml_sax-1.02-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.38_x86_64/perl_xml_sax-1.02-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6842d518e312d90fd0dd9e16f325b3d46b3255a45cf20e79579ae750c30a6f9e',
     armv7l: '6842d518e312d90fd0dd9e16f325b3d46b3255a45cf20e79579ae750c30a6f9e',
       i686: '15a9776766bf25e236144cc1ac88cf3ebd9c9bba34db0f7d93f485b99197daef',
     x86_64: 'd0db3f97bdb2ab1574c707c24af7c2136bacbe291c0df64dd1ba90907a42f822'
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
