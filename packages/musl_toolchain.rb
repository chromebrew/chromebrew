require 'package'
require_relative 'musl_cc_toolchain'

class Musl_toolchain < Package
  description Musl_cc_toolchain.description
  homepage Musl_cc_toolchain.homepage
  version Musl_cc_toolchain.version
  license Musl_cc_toolchain.license
  compatibility Musl_cc_toolchain.compatibility

  is_fake

  depends_on 'musl_cc_toolchain' unless ARCH == 'i686'
  depends_on 'musl_native_toolchain' if ARCH == 'i686'
end
