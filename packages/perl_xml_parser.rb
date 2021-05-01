require 'package'

class Perl_xml_parser < Package
  description 'Perl XML::Parser - A perl module for parsing XML documents'
  homepage 'https://metacpan.org/pod/XML::Parser'
  version '2.46'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz'
  source_sha256 'd331332491c51cccfb4cb94ffc44f9cd73378e618498d4a37df9e043661c515d'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46_armv7l/perl_xml_parser-2.46-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46_armv7l/perl_xml_parser-2.46-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46_i686/perl_xml_parser-2.46-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_xml_parser/2.46_x86_64/perl_xml_parser-2.46-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '19c9f04e36592ba130c178c0b19a0418959f7dbc5ff69d926cc7d7953ebf5ce8',
     armv7l: '19c9f04e36592ba130c178c0b19a0418959f7dbc5ff69d926cc7d7953ebf5ce8',
       i686: 'a8be7da651c6064359978d81c536511c225f62d17a2c8d498b8290a48c6104ff',
     x86_64: 'ba095c1e93328e0117c3ad5097dc4de88969f7ef70829e1d4d355afdb508f37d',
  })

  depends_on 'expat'
  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '--force', '.'

    # install lib
    libdir = CREW_DEST_DIR + `perl -e 'require Config; print $Config::Config{'"'installsitelib'"'};'`
    FileUtils.mkdir_p libdir
    system "(cd build/lib/perl5; tar cf - .) | (cd #{libdir}; tar xfp -)"

    # install man
    FileUtils.mkdir_p CREW_DEST_MAN_PREFIX
    system "(cd build/man; tar cf - .) | (cd #{CREW_DEST_MAN_PREFIX}; tar xfp -)"
  end

  def self.check
  end
end
