require 'buildsystems/autotools'

class Wcslib < Autotools
  description 'C library that implements the "World Coordinate System" (WCS) standard in FITS (Flexible Image Transport System).'
  homepage 'https://www.atnf.csiro.au/people/mcalabre/WCS/wcslib/'
  version '8.9'
  license 'Copyright (C) 1995-2023, Mark Calabretta'
  compatibility 'all'
  source_url "https://www.atnf.csiro.au/computing/software/wcs/wcslib-releases/wcslib-#{version}.tar.bz2"
  source_sha256 '82ac09ce5091b0bf06cec8f5cdeec1dabe1d06ba5dfb7ff2bdb0c1680488807b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '389ea06fc147fd22fefc6bfc09ea8124e8a10d049e581a08de48e461ce9e3e25',
     armv7l: '389ea06fc147fd22fefc6bfc09ea8124e8a10d049e581a08de48e461ce9e3e25',
       i686: '4243fd3fed5a0a1732c90153f6eb1b677c687ce086bc035edefd6f04a466e56b',
     x86_64: '82714b7589fd80823f39f7a308f53ab35981ac4a45af6c797158e662d4d9fcff'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_pre_configure_options "LDFLAGS='-L#{CREW_LIB_PREFIX} #{CREW_ENV_OPTIONS_HASH['LDFLAGS']}'"
end
