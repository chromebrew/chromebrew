require 'package'

class Clisp < Package
  description 'ANSI Common Lisp compiler, interpreter and debugger.'
  homepage 'http://www.gnu.org/software/clisp/'
  version '2.49-3'
  source_url 'ftp://ftp.gnu.org/pub/gnu/clisp/release/2.49/clisp-2.49.tar.bz2'
  source_sha256 '8132ff353afaa70e6b19367a25ae3d5a43627279c25647c220641fed00f8e890'

  binary_url ({
  })
  binary_sha256 ({
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
