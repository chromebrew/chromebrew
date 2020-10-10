require 'package'

class Perl_file_tail < Package
  description 'Perl extension for reading from continously updated files'
  homepage 'https://metacpan.org/pod/File::Tail'
  version '1.3'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/M/MG/MGRABNAR/File-Tail-1.3.tar.gz'
  source_sha256 '26d09f81836e43eae40028d5283fe5620fe6fe6278bf3eb8eb600c48ec34afc7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perl_file_tail-1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f01dfbccd682bd74baea061f0143963cfd7271219eedfbd4ee659e7561096923',
     armv7l: 'f01dfbccd682bd74baea061f0143963cfd7271219eedfbd4ee659e7561096923',
       i686: '9cb02093a16544f73b266b6f6ca112a336ad2b0453e2a1e3f20f7e1087b973aa',
     x86_64: '16fef92f4059a8a047a8fc859f0297fbe2f7a056e7ab3f20a8d9a73c91334eda',
  })

  depends_on 'perl'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
