require 'package'
require_relative 'py3_six'

class Six < Package
  description Py3_six.description.to_s
  homepage Py3_six.homepage.to_s
  version Py3_six.version.to_s
  license Py3_six.license.to_s
  compatibility Py3_six.compatibility.to_s

  is_fake

  depends_on 'py3_six'
end
