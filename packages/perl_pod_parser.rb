require 'package'

class Perl_pod_parser < Package
  description 'Perl Pod::Parser - base class for creating POD filters and translators'
  homepage 'https://metacpan.org/pod/Pod::Parser'
  version '1.63-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MA/MAREKR/Pod-Parser-1.63.tar.gz'
  source_sha256 'dbe0b56129975b2f83a02841e8e0ed47be80f060686c66ea37e529d97aa70ccd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-1_armv7l/perl_pod_parser-1.63-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-1_armv7l/perl_pod_parser-1.63-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-1_i686/perl_pod_parser-1.63-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_pod_parser/1.63-1_x86_64/perl_pod_parser-1.63-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8ba74165129311c52ccf8add610eda8aba4ef5e7b24e4a7ed365fbe825837710',
     armv7l: '8ba74165129311c52ccf8add610eda8aba4ef5e7b24e4a7ed365fbe825837710',
       i686: 'a0ae78e4d2aafd3ef90d2b23fdf5bd5f43da4638b17183ac9e1cf7914e349625',
     x86_64: '75ee5ada7995eb9c7bc6c5199069c944107fe555cd1ef2a9df67ac60b5269908'
  })

  def self.build; end

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

  def self.check; end
end
