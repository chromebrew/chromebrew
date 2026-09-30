require 'buildsystems/autotools'

class Groff < Autotools
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.24.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/groff.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e3e7881ed8edbb0eda1e68a9efcf1d5d07176970e24f26cbb42da6dc0b7f1f61',
     armv7l: 'e3e7881ed8edbb0eda1e68a9efcf1d5d07176970e24f26cbb42da6dc0b7f1f61',
       i686: '02744d00fb0ec71f92edcbf3dc1c9785bcdfe456c1079291994b2b9e7bd3aaa0',
     x86_64: '198ae56f1bdaaa01a32c1c5f86a375b07e9442d115164ce217a7b4dfa4631f17'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'netpbm' => :build
  depends_on 'uchardet' => :executable

  autotools_configure_options '--without-x'

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

  def self.patch
    # See https://lists.gnu.org/archive/html/groff/2024-11/msg00149.html
    File.write '.tarball-version', <<~EOF
      #{version}
    EOF
  end
end
