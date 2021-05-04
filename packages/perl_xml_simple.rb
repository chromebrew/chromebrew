require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version '2.25-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-2_armv7l/perl_xml_simple-2.25-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-2_armv7l/perl_xml_simple-2.25-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-2_i686/perl_xml_simple-2.25-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_simple/2.25-2_x86_64/perl_xml_simple-2.25-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c75d6a80e668aa4ca4515c0d4eaf57c81d95f43db722818b201f87e96a66295d',
     armv7l: 'c75d6a80e668aa4ca4515c0d4eaf57c81d95f43db722818b201f87e96a66295d',
       i686: '84d43b1ff8994d610b58d4084dc859a78cfbd1b614b037009b6af3149bc28434',
     x86_64: 'ae76a1851970fb669756a75b9f2b51b48e4687da515ab015c448eeb4eac9c422'
  })

  depends_on 'perl_xml_parser'

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
