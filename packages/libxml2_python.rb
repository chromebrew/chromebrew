require 'package'
require_relative 'py3_libxml2'

class Libxml2_python < Package
  description Py3_libxml2.description.to_s
  homepage Py3_libxml2.homepage.to_s
  version Py3_libxml2.version.to_s
  license Py3_libxml2.license.to_s
  compatibility Py3_libxml2.compatibility.to_s

  is_fake

  depends_on 'py3_libxml2'
end
