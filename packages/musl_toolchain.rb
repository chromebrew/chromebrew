require 'package'
require_relative 'musl_cc_toolchain'

class Musl_toolchain < Package
  description Musl_cc_toolchain.description.to_s
  homepage Musl_cc_toolchain.homepage.to_s
  version Musl_cc_toolchain.version.to_s
  license Musl_cc_toolchain.license.to_s
  compatibility Musl_cc_toolchain.compatibility.to_s

  is_fake

  depends_on 'musl_cc_toolchain' unless ARCH == 'i686'
  depends_on 'musl_native_toolchain' if ARCH == 'i686'
end
