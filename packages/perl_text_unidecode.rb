require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version '1.30-1'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-1.30.tar.gz'
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_unidecode-1.30-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '43b5783ca695cc44a5129fab5e176b24f94a300ab4e28f65ae9155c36dad93c8',
     armv7l: '43b5783ca695cc44a5129fab5e176b24f94a300ab4e28f65ae9155c36dad93c8',
       i686: 'd29c8c82aff2664ef8184bf225fe581c30cddcf632300c781eca4fcab9dd3732',
     x86_64: '0a862d29622f5516bee8b00706d7c59f2e2ed091c484c9366fa515dcab213581',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', 'build', '--self-contained', '.'

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
