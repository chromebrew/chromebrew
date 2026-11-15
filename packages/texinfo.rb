require 'buildsystems/autotools'

class Texinfo < Autotools
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version "7.3-#{CREW_PERL_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/texinfo/texinfo-#{version.split('-')[0]}.tar.xz"
  source_sha256 'e085acf253e094f159d7afab18cf740cf7a0c99d18d14c2d45ee221749bddf16'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bec0e538a542b3dada977842274016327ab0b5599ef35ece669f0dcfd39529ae',
     armv7l: 'bec0e538a542b3dada977842274016327ab0b5599ef35ece669f0dcfd39529ae',
       i686: '3201569a71459298dda505b507a90213639a9d40aecf232f32437f35192b602a',
     x86_64: '2c4d2e09931e910e08db528de6b8d252a523ae2cc459156aa2910c7b57dec0c7'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libunistring' => :library
  depends_on 'ncurses' => :executable
  depends_on 'perl' => :library
  depends_on 'perl' => :logical
  depends_on 'perl_libintl_perl' => :logical
  depends_on 'perl_text_unidecode' => :logical
  depends_on 'perl_unicode_eastasianwidth' => :logical

  def self.patch
    # The c11threads threads.h breaks builds on software that uses gnulib.
    # See: https://github.com/jtsiomb/c11threads/issues/19
    # Note that c11threads is a workaround for C11 Threads only being
    # introduced in Glibc 2.28 as per:
    # https://sourceware.org/bugzilla/show_bug.cgi?id=14092#c10
    if LIBC_VERSION.to_f < 2.28 && ENV['NESTED_CI']
      puts 'Removing the c11threads include/threads.h from the c11threads package to prevent build failures.'.orange
      FileUtils.rm_f "#{CREW_PREFIX}/include/threads.h"
    end
  end

  autotools_configure_options '--with-external-Text-Unidecode \
    --with-external-Unicode-EastAsianWidth'

  run_tests
end
