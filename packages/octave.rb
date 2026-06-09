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
    aarch64: 'bd9708082a6f4c3052e073bf9642c2b54d2e0bcc95aa305d6bc99676894b2e3a',
     armv7l: 'bd9708082a6f4c3052e073bf9642c2b54d2e0bcc95aa305d6bc99676894b2e3a',
     x86_64: '393c3e8cf5f81936be330275e7d4439fbd2da85bca44b3a69ec407a8273d106a'
  })

  depends_on 'bzip2' # R
  depends_on 'curl' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gnuplot' => :build
  depends_on 'gperf' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icoutils' => :build
  depends_on 'lapack' => :build
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'librsvg' => :build
  depends_on 'libsndfile' # R
  depends_on 'libx11' # R
  depends_on 'openblas' # R
  depends_on 'pcre2' # R
  depends_on 'readline' # R
  depends_on 'texinfo' => :build
  depends_on 'texlive_bin' => :build
  depends_on 'zlib' # R

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
