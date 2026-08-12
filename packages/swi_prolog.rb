require 'buildsystems/cmake'

class Swi_prolog < CMake
  description 'SWI-Prolog offers a comprehensive free Prolog environment.'
  homepage 'https://www.swi-prolog.org'
  version '10.1.5'
  license 'BSD-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/SWI-Prolog/swipl-devel.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3ee8a715b5dc861fa82e1735d9b35b1101c883725bb6966aad0866a97ccd796',
     armv7l: 'e3ee8a715b5dc861fa82e1735d9b35b1101c883725bb6966aad0866a97ccd796',
     x86_64: '6c3b1b3c153360fc3355f8a053bfdf27cc2dec13e3a54a27762eecd362e33c5e'
  })

  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libarchive' => :library
  depends_on 'libdb' => :library
  depends_on 'libedit' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'libyaml' => :library
  depends_on 'ncurses' => :library
  depends_on 'openjdk17' => :executable
  depends_on 'openssl' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'python3' => :library
  depends_on 'readline' => :library
  depends_on 'sdl3' => :library
  depends_on 'sdl3_image' => :library
  depends_on 'termcap' => :library
  depends_on 'zlib' => :library

  pre_cmake_options "CFLAGS+=' -I#{CREW_PREFIX}/include/ncurses'"
  cmake_options '-DCMAKE_BUILD_TYPE=PGO'

  def self.patch
    # Fix error: implicit declaration of function ‘va_start’.
    system "sed -i '35i#include <stdarg.h>' packages/libedit/libedit/src/terminal.c"
  end

  cmake_install_extras do
    if ARCH.eql?('x86_64')
      FileUtils.mv "#{CREW_DEST_PREFIX}/lib", CREW_DEST_LIB_PREFIX
      Dir["#{CREW_DEST_LIB_PREFIX}/swipl/bin/x86_64-linux/swipl*"].each do |binary|
        bin = File.basename(binary)
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/swipl/bin/x86_64-linux/#{bin}", "#{CREW_DEST_PREFIX}/bin/#{bin}"
      end
      Dir["#{CREW_DEST_LIB_PREFIX}/swipl/lib/x86_64-linux/*"].each do |library|
        lib = File.basename(library)
        FileUtils.ln_sf "#{CREW_LIB_PREFIX}/swipl/lib/x86_64-linux/#{lib}", "#{CREW_DEST_LIB_PREFIX}/#{lib}"
      end
    end
  end
end
