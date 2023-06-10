require 'package'
require_relative 'glibc_build'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage Glibc_build.homepage.to_s
  version Glibc_build.version.to_s
  license Glibc_build.license
  compatibility Glibc_build.compatibility.to_s

  is_fake

  depends_on 'glibc_libs'
end
