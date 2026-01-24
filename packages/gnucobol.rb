require 'package'

class Gnucobol < Package
  description 'GnuCOBOL (formerly OpenCOBOL) is a free COBOL compiler.'
  homepage 'https://www.gnu.org/software/gnucobol/'
  version '3.2'
  license 'GPL-3 and LGPL-3'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://downloads.sourceforge.net/project/gnucobol/gnucobol/#{version}/gnucobol-#{version}_bin.tar.xz"
  source_sha256 'c6e8aa801cbd46331a4cd352ed1599e955b6f62174ed01d848a8df4626e32f2f'

  depends_on 'cjson' # R
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'libdb' # R
  depends_on 'ncurses' # R

  no_compile_needed

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mv %w[usr/local/bin usr/local/include usr/local/share], CREW_DEST_PREFIX
    FileUtils.mv Dir['usr/local/lib/*'], CREW_DEST_LIB_PREFIX
  end
end
