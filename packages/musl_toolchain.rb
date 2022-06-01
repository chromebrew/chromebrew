require 'package'

class Musl_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  version '1.2.2-b76f37fd'
  compatibility 'all'
  license 'MIT, LGPL-2 and GPL-2'

  is_fake

  depends_on 'musl_cc_toolchain' unless ARCH == 'i686'
  depends_on 'musl_native_toolchain' if ARCH == 'i686'
end
