require 'package'

class Clisp < Package
  description 'ANSI Common Lisp compiler, interpreter and debugger.'
  homepage 'http://www.gnu.org/software/clisp/'
  version '2.49-3'
  case ARCH
  when 'i686', 'x86_64'
    source_url 'https://ftpmirror.gnu.org/clisp/release/2.49/clisp-2.49.tar.bz2'
    source_sha256 '8132ff353afaa70e6b19367a25ae3d5a43627279c25647c220641fed00f8e890'
  end

  binary_url ({
      i686: 'https://dl.bintray.com/chromebrew/chromebrew/clisp-2.49-3-chromeos-i686.tar.xz',
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/clisp-2.49-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
      i686: '1b05410ad735f382877d134eea7d26842de2e10fe028a6b3ca78f1774ab5c9e8',
    x86_64: '7d64a5724ef656764f35ce48dca877a9f9e75842a1a420fde21d12c8bf2f5489',
  })

  depends_on 'diffutils' => :build
  depends_on 'ffcall'
  depends_on 'libsigsegv'
  depends_on 'readline'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-static',
      '--with-pic',
      '--with-ffcall',
      '--with-readline'
    FileUtils.cd('src') do
      # disable unavailable "-R" option, modifying configure options doesn't work
      system 'sed', '-i', 'Makefile', '-e', "s:-R#{CREW_LIB_PREFIX} ::"
      system 'make', '-j1' # parallel builds fail
    end
  end

  def self.install
    FileUtils.cd('src') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
