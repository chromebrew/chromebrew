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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.36_armv7l/perl_file_tail-1.3-perl5.36-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.36_armv7l/perl_file_tail-1.3-perl5.36-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.36_i686/perl_file_tail-1.3-perl5.36-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-perl5.36_x86_64/perl_file_tail-1.3-perl5.36-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7f36ad64709384d0aa919db2ad2c4aec4f1de87be10a966f2add8527f41c95a5',
     armv7l: '7f36ad64709384d0aa919db2ad2c4aec4f1de87be10a966f2add8527f41c95a5',
       i686: '33030497ce4d3aa7fe0489423185e9a1f5749dade858369ee0c068f4920517b6',
     x86_64: 'a5a527045923405155d7dd85d6e5ce47f708ab62b29938148c482a8b59b16a00'
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
