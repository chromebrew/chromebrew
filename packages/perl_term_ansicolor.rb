require 'package'
require_relative 'perl'

class Perl_term_ansicolor < Package
  description 'Character mode terminal access for Perl Term::ANSIColor'
  homepage 'https://metacpan.org/pod/Term::ANSIColor'
  version Perl.version
  license 'GPL-1+ or Artistic'
  compatibility 'all'

  # included in main perl package
  is_fake
end
