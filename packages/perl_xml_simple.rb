require 'package'

class Perl_xml_simple < Package
  description 'XML::Simple - An API for simple XML files'
  homepage 'https://metacpan.org/pod/XML::Simple'
  version '2.25'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/G/GR/GRANTM/XML-Simple-2.25.tar.gz'
  source_sha256 '531fddaebea2416743eb5c4fdfab028f502123d9a220405a4100e68fc480dbf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_xml_simple-2.25-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2efbab66fa6fb4366cf7858730a1735cca8b8908e9177efab82681e3cc225ada',
     armv7l: '2efbab66fa6fb4366cf7858730a1735cca8b8908e9177efab82681e3cc225ada',
       i686: '4f9ac7dcea9016a27d1c9d7652c78e995dbaa6d01d4ffdd4f6891e979310768a',
     x86_64: 'c7add802bb163ef97c3e5e3746c0af744cb811477f0d915c2b3b46d01fa03908',
  })

  depends_on 'perl_xml_parser'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '--force', '.'

    # install lib
    libdir = `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    system "mkdir -p #{CREW_DEST_DIR}#{libdir}"
    system "(cd build/lib/perl5; tar cf - .) | (cd #{CREW_DEST_DIR}#{libdir}; tar xfp -)"

    # install man
    mandir = "#{CREW_PREFIX}/share/man"
    system "mkdir -p #{CREW_DEST_DIR}#{mandir}"
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_DIR}#{mandir}; tar xfp -)"
  end

  def self.check
  end
end
