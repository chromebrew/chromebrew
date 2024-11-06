require 'package'
Package.load_package("#{__dir__}/perl_unicode_linebreak.rb")

class Perl_gcstring_linebreak < Package
  description 'UAX 14 Unicode Line Breaking Algorithm - Perl binding Unicode::LineBreak Unicode::GCString'
  homepage 'http://search.cpan.org/~nezumi/Unicode-LineBreak-2018.003/lib/Unicode/LineBreak.pod'
  version Perl_unicode_linebreak.version
  license 'GPL-1+ or Artistic'
  compatibility 'all'

  is_fake
end
