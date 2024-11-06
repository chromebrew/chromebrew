require 'package'
Package.load_package("#{__dir__}/py3_six.rb")

class Six < Package
  description Py3_six.description
  homepage Py3_six.homepage
  version Py3_six.version
  license Py3_six.license
  compatibility Py3_six.compatibility

  is_fake

  depends_on 'py3_six'
end
