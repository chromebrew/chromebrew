require 'buildsystems/autotools'

class Octave < Autotools
  description 'Scientific Programming Language'
  homepage 'https://octave.org/'
  version '11.3.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftp.gnu.org/gnu/octave/octave-#{version}.tar.lz"
  source_sha256 '4057e37ec2cbf98a78ca3412e56718ba567c3797a77b9bfd8cb2c2b8e044b270'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1cfc5fc1e2f26950ce3c8a5f5e1a511114b09041157b92304f65b7e9a107f2e',
     armv7l: 'c1cfc5fc1e2f26950ce3c8a5f5e1a511114b09041157b92304f65b7e9a107f2e',
     x86_64: '6a6ff0554a580b12bd306914d7b3d53d91e8362b366101b2413a1a34d4b46e00'
  })

  depends_on 'bzip2' => :library
  depends_on 'curl' => :library
  depends_on 'fftw' => :library
  depends_on 'fontconfig' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnuplot' => :build
  depends_on 'gperf' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icoutils' => :build
  depends_on 'lapack' => :build
  depends_on 'libglu' => :library
  depends_on 'libglvnd' => :library
  depends_on 'librsvg' => :build
  depends_on 'libsndfile' => :library
  depends_on 'libx11' => :library
  depends_on 'openblas' => :library
  depends_on 'pcre2' => :library
  depends_on 'readline' => :library
  depends_on 'texinfo' => :build
  depends_on 'texlive_bin' => :build
  depends_on 'wayland' => :library
  depends_on 'zlib' => :library

  run_tests

  def self.prebuild
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

  # docs build fails with this error:
  # "texi2dvi: Your TeX installation appears to be broken" error.
  # See https://savannah.gnu.org/bugs/index.php?68437
  autotools_configure_options '--disable-docs \
                               --disable-rpath \
                               --disable-static \
                               --enable-shared'
end
