require 'package'

class Perl_file_tail < Package
  description 'File::Tail - Perl extension for reading from continuously updated files'
  homepage 'https://metacpan.org/pod/File::Tail'
  version '1.3-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MG/MGRABNAR/File-Tail-1.3.tar.gz'
  source_sha256 '26d09f81836e43eae40028d5283fe5620fe6fe6278bf3eb8eb600c48ec34afc7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '280d508b854028a07ab39a689ad7e4ee4584b8f70d627243b1120dfbbd6cc7a3',
     armv7l: '280d508b854028a07ab39a689ad7e4ee4584b8f70d627243b1120dfbbd6cc7a3',
       i686: '4431973033c63c66453d3363952e5878e796c1fcdfbb50e6b63fd97c2c1425f9',
     x86_64: 'a7a3f390fc47efc72df0c8b54774dba9d0a97c22d0a19cae54bab1f3eee0158c'
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
