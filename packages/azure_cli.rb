require 'package'
require_relative 'py3_azure_cli'

class Azure_cli < Package
  description Py3_azure_cli.description
  homepage Py3_azure_cli.homepage
  version Py3_azure_cli.version
  license Py3_azure_cli.license
  compatibility Py3_azure_cli.compatibility

  is_fake

  depends_on 'py3_azure_cli'
end
