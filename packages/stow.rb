require 'package'
require_relative 'perl_stow'

class Stow < Package
  description Perl_stow.description.to_s
  homepage Perl_stow.homepage.to_s
  version Perl_stow.version.to_s
  license Perl_stow.license.to_s
  compatibility Perl_stow.compatibility.to_s

  depends_on 'perl_stow'

  is_fake
end
