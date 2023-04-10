require 'package'
require_relative 'avocado_framework'

class Avocado < Package
  description Avocado_framework.description.to_s
  homepage Avocado_framework.homepage.to_s
  version Avocado_framework.version.to_s
  license Avocado_framework.license.to_s
  compatibility Avocado_framework.compatibility.to_s

  is_fake

  depends_on 'avocado_framework'
end
