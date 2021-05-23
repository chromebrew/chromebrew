require 'package'

class Perl_file_tail < Package
  description 'Perl extension for reading from continuously updated files'
  homepage 'https://metacpan.org/pod/File::Tail'
  version '1.3-1'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MG/MGRABNAR/File-Tail-1.3.tar.gz'
  source_sha256 '26d09f81836e43eae40028d5283fe5620fe6fe6278bf3eb8eb600c48ec34afc7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-1_armv7l/perl_file_tail-1.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-1_armv7l/perl_file_tail-1.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-1_i686/perl_file_tail-1.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/perl_file_tail/1.3-1_x86_64/perl_file_tail-1.3-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a4ef2b1c64d500ab70f1e2bfa1eea3b9c4872ff1cd0479a340a8953583237e80',
     armv7l: 'a4ef2b1c64d500ab70f1e2bfa1eea3b9c4872ff1cd0479a340a8953583237e80',
       i686: 'e7598c65f241246fe6d4c95db13288675d3d150ba7fbc6285fee5ee01d9f6fa8',
     x86_64: '2eb28e0e5cca3cab45a9bada46f58cbb793464df95f033e2dac025c44d65efd3'
  })

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
