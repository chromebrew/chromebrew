require 'buildsystems/perl'

class Perl_clone < PERL
  description 'Recursively copy Perl datatypes'
  homepage 'https://metacpan.org/pod/Clone'
  version "0.50-#{CREW_PERL_VER}"
  license 'GPL-1+ or Artistic'
  compatibility 'all'
  source_url "https://cpan.metacpan.org/authors/id/A/AT/ATOOMIC/Clone-#{version.split('-')[0]}.tar.gz"
  source_sha256 'f9732a4a857974db30905233589113003301b585b0cecda29a21cfba5bb014f9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b34bd696263c1244df60111dffe89ef554eca5aaa57b8b31b1484dfdb6a3e5c3',
     armv7l: 'b34bd696263c1244df60111dffe89ef554eca5aaa57b8b31b1484dfdb6a3e5c3',
       i686: 'ec7cdbbe35fb43f9e10354f2528a667253d0afd101c7e61b41283834f994d480',
     x86_64: 'fead8bfbcd2b1850d9baa2b2524556fd97fe241f021dacfd5815b94312eb66fe'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'perl' => :logical
end
