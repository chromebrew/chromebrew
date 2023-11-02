require 'package'
require_relative 'py3_azure_cli'

class Az < Package
  description Py3_azure_cli.description.to_s
  homepage Py3_azure_cli.homepage.to_s
  version Py3_azure_cli.version.to_s
  license Py3_azure_cli.license.to_s
  compatibility Py3_azure_cli.compatibility.to_s

  is_fake

  depends_on 'py3_azure_cli'
end
