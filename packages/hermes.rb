require 'package'
Package.load_package("#{__dir__}/py3_hermes_agent.rb")

class Hermes < Package
  description Py3_hermes_agent.description
  homepage Py3_hermes_agent.homepage
  version Py3_hermes_agent.version
  license Py3_hermes_agent.license
  compatibility Py3_hermes_agent.compatibility

  is_fake

  depends_on 'py3_hermes_agent'
end
