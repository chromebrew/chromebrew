require 'package'
Package.load_package("#{__dir__}/perl_stow.rb")

class Stow < Package
  description Perl_stow.description
  homepage Perl_stow.homepage
  version Perl_stow.version
  license Perl_stow.license
  compatibility Perl_stow.compatibility

  depends_on 'perl_stow'

  is_fake
end
