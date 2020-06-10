require 'package'

class Perl_text_charwidth < Package
  description 'Text::CharWidth - Get number of occupied columns of a string on terminals'
  homepage 'https://metacpan.org/pod/Text::CharWidth'
  version '0.04'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-CharWidth-0.04.tar.gz'
  source_sha256 'abded5f4fdd9338e89fd2f1d8271c44989dae5bf50aece41b6179d8e230704f8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_text_charwidth-0.04-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34c7986c7a9f0cbcf4540589008993463b26dc7a35dd640530eb63d5eda686d3',
     armv7l: '34c7986c7a9f0cbcf4540589008993463b26dc7a35dd640530eb63d5eda686d3',
       i686: 'e08cd144f70759d29e21d244fa8bdd42b57e44944cf6e20bfd49273a493f2281',
     x86_64: '0f36d56af9de52d9b4f65f8d5f231b2fe0e4faf4b534906cf2e949fcc8b4c1a5',
  })

  depends_on 'perl'

  def self.build
  end

  def self.install
    # install files to build directory
    system 'cpanm', '-l', "build", '--self-contained', '.'

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
