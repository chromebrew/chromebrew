require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version '1.30-2'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-1.30.tar.gz'
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-2_armv7l/perl_text_unidecode-1.30-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-2_armv7l/perl_text_unidecode-1.30-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-2_i686/perl_text_unidecode-1.30-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_text_unidecode/1.30-2_x86_64/perl_text_unidecode-1.30-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c26b735942fd9bb1fc193ecfdffdab25bce5c208dc3ed61c819e21b7fda5f502',
     armv7l: 'c26b735942fd9bb1fc193ecfdffdab25bce5c208dc3ed61c819e21b7fda5f502',
       i686: '4fc5095c5d47286e895ed3ef2b5c631a061c1ab62a0781dbfe5ffb141cc36bb9',
     x86_64: '763201f6d7fc90327300341c4a33b43e2a60164fa33ce20c1c9f47e00231d5e3'
  })

  def self.build; end

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

  def self.check; end
end
