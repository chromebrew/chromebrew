require 'package'

class Perl_file_tail < Package
  description 'File::Tail - Perl extension for reading from continuously updated files'
  homepage 'https://metacpan.org/pod/File::Tail'
  version '1.3-perl5.38'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MG/MGRABNAR/File-Tail-1.3.tar.gz'
  source_sha256 '26d09f81836e43eae40028d5283fe5620fe6fe6278bf3eb8eb600c48ec34afc7'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.38_armv7l/perl_file_tail-1.3-perl5.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.38_armv7l/perl_file_tail-1.3-perl5.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.38_i686/perl_file_tail-1.3-perl5.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.38_x86_64/perl_file_tail-1.3-perl5.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1a5261cf6d91a837edcdf5fe00e16f072edbe8fd504081c4717073f8c86900a2',
     armv7l: '1a5261cf6d91a837edcdf5fe00e16f072edbe8fd504081c4717073f8c86900a2',
       i686: '4d33df3438bd645491d93b2d1aaeafb9faa27709268efb3a4752fe0c5a95855d',
     x86_64: '16bcde971b49bb85f5e8802093bcd20d7cc2273d200a0bec88cd36090669fd87'
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
