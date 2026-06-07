require 'buildsystems/autotools'

class Gutenprint < Autotools
  description 'High quality drivers for Canon, Epson, Lexmark, Sony, Olympus, and PCL printers for use with CUPS and GIMP.'
  homepage 'https://gimp-print.sourceforge.io/'
  version '5.3.5'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/gimp-print/gutenprint-#{version.sub(/\.\d+$/, '')}/#{version}/gutenprint-#{version}.tar.xz"
  source_sha256 'f5a9f47de28530b1ae2069cfbc647a9a641baeeabe809bb0ef2b3ec5b9668d70'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d81ece7322bc66dd87817414da1c1f6707b6706d53b58c65b6d47d983394bae',
     armv7l: '9d81ece7322bc66dd87817414da1c1f6707b6706d53b58c65b6d47d983394bae',
       i686: 'b9375679e96a366a33135c0dc47c272c76252788cfa77ae87b11fc1ac31a1430',
     x86_64: 'ff9831aaf8160e2d2e1e208a9b25dd83e9ecdad195269a553e5d61d87e24b6dd'
  })

  depends_on 'cups' => :library
  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libusb' => :library
  depends_on 'ncurses' => :library
  depends_on 'readline' => :library
  depends_on 'zlib' => :library

  autotools_install_extras do
    if ARCH.eql?('x86_64')
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX
    end
  end
end
