require 'package'
require_relative 'py3_libxml2'

class Libxml2_python < Package
  description Py3_libxml2.description
  homepage Py3_libxml2.homepage
  version Py3_libxml2.version
  license Py3_libxml2.license
  compatibility Py3_libxml2.compatibility

  is_fake

  depends_on 'py3_libxml2'
end
