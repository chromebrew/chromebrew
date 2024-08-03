require 'package'
Package.load_package("#{__dir__}/py3_libxml2.rb")

class Libxml2_python < Package
  description Py3_libxml2.description
  homepage Py3_libxml2.homepage
  version Py3_libxml2.version
  license Py3_libxml2.license
  compatibility Py3_libxml2.compatibility

  is_fake

  depends_on 'py3_libxml2'
end
