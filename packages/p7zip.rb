require 'package'
require_relative 'pkg_7_zip'

class P7zip < Package
  description Pkg_7_zip.description.to_s
  homepage Pkg_7_zip.homepage.to_s
  version Pkg_7_zip.version.to_s
  license Pkg_7_zip.license.to_s
  compatibility Pkg_7_zip.compatibility.to_s

  is_fake

  depends_on 'pkg_7_zip'
end
