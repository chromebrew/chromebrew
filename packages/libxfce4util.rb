require 'buildsystems/autotools'

class Libxfce4util < Autotools
  description 'Utility library for the Xfce4 desktop environment'
  homepage 'https://xfce.org/'
  version '4.19.3'
  license 'LGPL-2+ and GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://archive.xfce.org/src/xfce/libxfce4util/4.19/libxfce4util-#{version}.tar.bz2"
  source_sha256 'f047937f753466b7ff74ad3809c817b11db44498dd90497de7e1584ee48502c6'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e78230be262113082306c9d0f9721022585aa570ce5421992e37c8e32b413b3b',
     armv7l: 'e78230be262113082306c9d0f9721022585aa570ce5421992e37c8e32b413b3b',
     x86_64: '396ad555b42b55134e855630a0d09cd8911502e196c6d1d3ed3ab0006d03d664'
  })

  depends_on 'gobject_introspection'

  run_tests
end
