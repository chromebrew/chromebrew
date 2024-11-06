require 'package'
Package.load_package("#{__dir__}/github_cli.rb")

class Gh < Package
  description Github_cli.description
  homepage Github_cli.homepage
  version Github_cli.version
  license Github_cli.license
  compatibility Github_cli.compatibility

  is_fake

  depends_on 'github_cli'
end
