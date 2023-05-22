require 'package'

class Perl_read_key < Package
  description 'Term::ReadKey - A perl module for simple terminal control'
  homepage 'https://metacpan.org/pod/Term::ReadKey'
  version '2.38-perl5.36'
  license 'GPL-1+ or Artistic'
  compatibility 'all'

  is_fake

  depends_on 'perl_term_readkey' => :build
end
