require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version '2.25-1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1e59e0c43b8bfecf21365d9ee0b58db3faa544f07da1aa349734ba34b75541a0',
     armv7l: '1e59e0c43b8bfecf21365d9ee0b58db3faa544f07da1aa349734ba34b75541a0',
       i686: 'e035d818f9ef397fbc8f4f9e0aa95dc360c797931808f03e46a7cf7a7393a158',
     x86_64: '13dd6b54550fc74148e635ea6ef7afecbe49ae691b85e745f4ed5e0667da79e6',
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
