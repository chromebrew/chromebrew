require 'package'
Package.load_package("#{__dir__}/acquia_cli.rb")

class Acli < Package
  description Acquia_cli.description
  homepage Acquia_cli.homepage
  version Acquia_cli.version
  license Acquia_cli.license
  compatibility Acquia_cli.compatibility

  is_fake

  depends_on 'acquia_cli'
end
