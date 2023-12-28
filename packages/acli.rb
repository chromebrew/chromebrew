require 'package'
require_relative 'acquia_cli'

class Acli < Package
  description Acquia_cli.description
  homepage Acquia_cli.homepage
  version Acquia_cli.version
  license Acquia_cli.license
  compatibility Acquia_cli.compatibility

  is_fake

  depends_on 'acquia_cli'
end
