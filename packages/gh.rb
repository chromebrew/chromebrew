require 'package'
require_relative 'github_cli'

class Gh < Package
  description Github_cli.description
  homepage Github_cli.homepage
  version Github_cli.version
  license Github_cli.license
  compatibility Github_cli.compatibility

  is_fake

  depends_on 'github_cli'
end
