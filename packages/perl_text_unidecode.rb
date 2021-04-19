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
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/perl_text_unidecode-1.30-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/perl_text_unidecode-1.30-2-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/perl_text_unidecode-1.30-2-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/perl_text_unidecode-1.30-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0fb6cfb59c797bb0d5c94e7a06460f1863e4b03587d86d33be384d2cd80aa872',
     armv7l: '0fb6cfb59c797bb0d5c94e7a06460f1863e4b03587d86d33be384d2cd80aa872',
       i686: 'ef13e84d29e03bba52f2ab3dc2a20d0955e3440f2da50f69d3c5832f428a28f5',
     x86_64: '9f9ace5d05847bb7d697fd27b02c43d3ef5224d7e036b5ac635b99409ee0142e'
  })

  depends_on 'perl'

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
