require 'package'

class Perl_text_charwidth < Package
  description 'Text::CharWidth - Get number of occupied columns of a string on terminals'
  homepage 'https://metacpan.org/pod/Text::CharWidth'
  version '0.04-perl-5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/K/KU/KUBOTA/Text-CharWidth-0.04.tar.gz'
  source_sha256 'abded5f4fdd9338e89fd2f1d8271c44989dae5bf50aece41b6179d8e230704f8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb79b142a945e01dae2d33d7a0219509fe6f9d4fff67edc9cf9b0298ac6cdf61',
     armv7l: 'eb79b142a945e01dae2d33d7a0219509fe6f9d4fff67edc9cf9b0298ac6cdf61',
       i686: '69e4e117b0d22cb2b230ef48ccf1a0b660f218ec08f2127e368a31b864eae21f',
     x86_64: '50dc30e26bc35e7e83bfeadea1263d96ad75932766da1197f811ab621e8b124b'
  })

  depends_on 'glibc' # R

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
