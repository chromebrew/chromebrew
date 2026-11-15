require 'buildsystems/autotools'

class Wcslib < Autotools
  description 'C library that implements the "World Coordinate System" (WCS) standard in FITS (Flexible Image Transport System).'
  homepage 'https://www.atnf.csiro.au/people/mcalabre/WCS/wcslib/'
  version '8.10'
  license 'Copyright (C) 1995-2023, Mark Calabretta'
  compatibility 'all'
  source_url "https://www.atnf.csiro.au/computing/software/wcs/wcslib-releases/wcslib-#{version}.tar.bz2"
  source_sha256 'b394d3306da9a52410f056136911496e599b5c48f1cff2f221563697077bbd8d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1e45145d399d2717ce6077e1702edeb899e6317359ddc31c4afad0bfe516a93',
     armv7l: 'f1e45145d399d2717ce6077e1702edeb899e6317359ddc31c4afad0bfe516a93',
       i686: 'f739cce96d1daeef32d9a712713c4337e03d2712742c407e54a26d33ff5bfed2',
     x86_64: '606b098caf3ae92c9a8da87f8c40f7b21107b94c01c7a997a18717736a865d87'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_pre_configure_options "LDFLAGS='-L#{CREW_LIB_PREFIX} #{CREW_ENV_OPTIONS_HASH['LDFLAGS']}'"
end
