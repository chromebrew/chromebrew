require 'package'
require_relative 'pkg_7_zip'

class P7zip < Package
  description Pkg_7_zip.description
  homepage Pkg_7_zip.homepage
  version Pkg_7_zip.version
  license Pkg_7_zip.license
  compatibility Pkg_7_zip.compatibility

  is_fake

  depends_on 'pkg_7_zip'
end
