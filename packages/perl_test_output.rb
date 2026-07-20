require 'package'

class Perl_test_output < Package
  description 'Test::Output - Utilities to test STDOUT and STDERR messages.'
  homepage 'https://metacpan.org/pod/Test::Output'
  version "1.034-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Test-Output-1.034.tar.gz'
  source_sha256 'cd42e2801c0d2b482d18c9fb4b06c757054818bcbb2824e5dfbf33ad7a3d69a0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7348219e12bc40876841d03d6b4510a59528d3459a7a783c3a4bf15a7cbce9df',
     armv7l: '7348219e12bc40876841d03d6b4510a59528d3459a7a783c3a4bf15a7cbce9df',
       i686: 'bd27bbf62a19bc6e1f627bdc1db393e1b192139cf8ff3a98222396ff14250941',
     x86_64: 'f518495df50fcb4732cbb2ea20fd0f48dfb6150579bec6fef6337a52fb9b5a31'
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
