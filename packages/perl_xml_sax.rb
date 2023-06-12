require 'package'

class Perl_xml_sax < Package
  description 'XML::SAX - Simple API for XML'
  homepage 'https://metacpan.org/pod/XML::SAX'
  version '1.02-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-SAX-1.02.tar.gz'
  source_sha256 '4506c387043aa6a77b455f00f57409f3720aa7e553495ab2535263b4ed1ea12a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.36_armv7l/perl_xml_sax-1.02-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.36_armv7l/perl_xml_sax-1.02-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.36_i686/perl_xml_sax-1.02-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_sax/1.02-perl5.36_x86_64/perl_xml_sax-1.02-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '00ed58352b250549f167f063a5c3c3005edb724093306147de57fa503fe5fb67',
     armv7l: '00ed58352b250549f167f063a5c3c3005edb724093306147de57fa503fe5fb67',
       i686: '267d169d06a21e6fe69298c65918db4317788af4ad090cfb629a58584d210af5',
     x86_64: 'a0a5847eab1354572e1623b9a4e167d38230125b87b30168a8c47904863f6c25'
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
