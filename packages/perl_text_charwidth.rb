require 'package'

class Perl_text_charwidth < Package
  description 'Text::CharWidth - Get number of occupied columns of a string on terminals'
  homepage 'https://metacpan.org/pod/Text::CharWidth'
  version '0.04-3'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-CharWidth-0.04.tar.gz'
  source_sha256 'abded5f4fdd9338e89fd2f1d8271c44989dae5bf50aece41b6179d8e230704f8'

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
