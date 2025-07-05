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
    aarch64: '5287148fc2577817b063407a5315a135732ca35640120c01bed8de834f3869db',
     armv7l: '5287148fc2577817b063407a5315a135732ca35640120c01bed8de834f3869db',
       i686: '60dac3421aa63c86a6efc6eb705d1a15cf62f38babe0bf3d3a9d9ae43c12bc8c',
     x86_64: 'fafdcc8354794227b310259021024219c8c5c3b94bec70d11a796ac705027bac'
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
