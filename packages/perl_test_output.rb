require 'package'

class Perl_test_output < Package
  description 'Test::Output - Utilities to test STDOUT and STDERR messages.'
  homepage 'https://metacpan.org/pod/Test::Output'
  version '1.034-perl5.40'
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url 'https://cpan.metacpan.org/authors/id/B/BD/BDFOY/Test-Output-1.034.tar.gz'
  source_sha256 'cd42e2801c0d2b482d18c9fb4b06c757054818bcbb2824e5dfbf33ad7a3d69a0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd04dd472af75ed65c49fa7647c5366790862a5685b2c7f381ff2d5ad26bdf8fe',
     armv7l: 'd04dd472af75ed65c49fa7647c5366790862a5685b2c7f381ff2d5ad26bdf8fe',
       i686: 'e1c998b7091028a53ceae43e2ad8bcf39a5299e9690db9e346d28417469f2a7f',
     x86_64: '9c59093829f6d40370bb0fc62271ad1f2cdabba3b1bcefd356d1bf546dda5288'
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
