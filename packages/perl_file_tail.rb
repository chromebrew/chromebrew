require 'package'

class Perl_file_tail < Package
  description 'File::Tail - Perl extension for reading from continuously updated files'
  homepage 'https://metacpan.org/pod/File::Tail'
  version '1.3-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MG/MGRABNAR/File-Tail-1.3.tar.gz'
  source_sha256 '26d09f81836e43eae40028d5283fe5620fe6fe6278bf3eb8eb600c48ec34afc7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-2_armv7l/perl_file_tail-1.3-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-2_armv7l/perl_file_tail-1.3-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-2_i686/perl_file_tail-1.3-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-2_x86_64/perl_file_tail-1.3-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c5f9386679af386e3fa96ee921871549900359ead67d3655f652ed4ad7601c8b',
     armv7l: 'c5f9386679af386e3fa96ee921871549900359ead67d3655f652ed4ad7601c8b',
       i686: 'b0320cc0f1832ccd1b78bfa6cf668f0bdd7064e84a793ce2803c9510225dbb60',
     x86_64: '6577ddae800348de9ae655fdbbb24d16ac51bf41b9e73555926ea2f53d6abec2'
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
