require 'package'

class Perl_text_unidecode < Package
  description 'Perl Text::Unidecode -- plain ASCII transliterations of Unicode text.'
  homepage 'https://metacpan.org/pod/Text::Unidecode'
  version "1.30-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/S/SB/SBURKE/Text-Unidecode-1.30.tar.gz'
  source_sha256 '6c24f14ddc1d20e26161c207b73ca184eed2ef57f08b5fb2ee196e6e2e88b1c6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f311fb1d2daccf6d5f5b5c7e4f0e405d4d2f27ba029696d1979b0465d61800a',
     armv7l: '0f311fb1d2daccf6d5f5b5c7e4f0e405d4d2f27ba029696d1979b0465d61800a',
       i686: '099a6d9e7ccd3ee40d033ee14f0cbf0b0533fff4f0fc77fc1e5f8aec2a8243a9',
     x86_64: '7a59ca05505962d743f6385ded0e3e21dbb076f5e42e37d093147a4689efb911'
  })

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
