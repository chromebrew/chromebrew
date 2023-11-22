require 'buildsystems/autotools'

class Wcslib < Autotools
  description 'C library that implements the "World Coordinate System" (WCS) standard in FITS (Flexible Image Transport System).'
  homepage 'https://www.atnf.csiro.au/people/mcalabre/WCS/wcslib/'
  version '8.2.1'
  license 'Copyright (C) 1995-2023, Mark Calabretta'
  compatibility 'all'
  source_url 'https://www.atnf.csiro.au/people/mcalabre/WCS/wcslib-8.2.1.tar.bz2'
  source_sha256 'b666c79568fc0cf16b6d585ff3d560ae5e472c3b1125a90ccc8038f8e84aca19'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wcslib/8.2.1_armv7l/wcslib-8.2.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wcslib/8.2.1_armv7l/wcslib-8.2.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wcslib/8.2.1_i686/wcslib-8.2.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wcslib/8.2.1_x86_64/wcslib-8.2.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'db36d11b51c6b9b41178a9a783162a1d1f846a70b9d8d13403f66fdb757b4189',
     armv7l: 'db36d11b51c6b9b41178a9a783162a1d1f846a70b9d8d13403f66fdb757b4189',
       i686: '618d931f5e1115e487d13f6d7fab99f8976b995dbfd44cfd61e92e5303becd90',
     x86_64: 'c2bba8126d82b1b8a7fe559477fbb9bbf1ebdcccc2277a70924d1aaa1d6004a9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  pre_configure_options "LDFLAGS='-L#{CREW_LIB_PREFIX} #{CREW_ENV_OPTIONS_HASH['LDFLAGS']}'"
end
