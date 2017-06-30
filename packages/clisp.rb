require 'package'

class Clisp < Package
  description 'ANSI Common Lisp compiler, interpreter and debugger.'
  homepage 'http://www.gnu.org/software/clisp/'
  version '2.49-2'
  source_url 'ftp://ftp.gnu.org/pub/gnu/clisp/release/2.49/clisp-2.49.tar.bz2'
  source_sha256 '8132ff353afaa70e6b19367a25ae3d5a43627279c25647c220641fed00f8e890'

  depends_on 'libsigsegv'
  depends_on 'ffcall'

  def self.build
    system "./configure", "--disable-static", "--enable-static", "--with-pic"
    FileUtils.cd('src') do
      # disable unavailable "-R" option
      # modifying configure options doesn't work for this
      system "sed", "-i", "Makefile", "-e", "s:-R/usr/local/lib ::"

      # force to compile in sequential since clisp Makefile doesn't work in parallel
      system "make", "-j1"
    end
  end

  def self.install
    FileUtils.cd('src') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
