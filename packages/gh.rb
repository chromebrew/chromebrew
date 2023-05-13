require 'package'
require_relative 'github_cli'

class Gh < Package
  description Github_cli.description.to_s
  homepage Github_cli.homepage.to_s
  version Github_cli.version.to_s
  license Github_cli.license.to_s
  compatibility Github_cli.compatibility.to_s

  is_fake

  depends_on 'github_cli'
end
