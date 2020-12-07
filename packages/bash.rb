require 'package'

class Bash < Package
  description 'The Bourne Again SHell'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1.tar.gz'
  source_sha256 'cc012bc860406dcf42f64431bcd3d2fa7560c02915a601aba9cd597a39329baa'

  depends_on 'llvm' => :build # Needed only for lld, which appears to allow linking libiconv where ld does not.
  depends_on 'ncurses' => :build # A static enabled ncurses build w/o "--without-normal" is required to build.

  def self.build
    ENV['LD'] = 'lld'
    system "./configure #{CREW_OPTIONS} --with-curses --enable-readline \
      --with-gnu-malloc --enable-mem-scramble --enable-usg-echo-default \
      --enable-single-help-strings --enable-select \
      --enable-restricted --enable-progcomp --enable-process-substitution \
      --enable-net-redirections --enable-multibyte --enable-job-control \
      --enable-history --enable-help-builtin --enable-dparen-arithmetic \
      --enable-directory-stack --enable-coprocesses --enable-cond-regexp \
      --enable-cond-command --enable-command-timing --enable-casemod-expansions \
      --enable-casemod-attributes --enable-brace-expansion --enable-bang-history \
      --enable-array-variables --enable-arith-for-command --enable-alias \
      --enable-static-link"
    system 'make'
  end

  def self.install
     system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
     FileUtils.ln_s "#{CREW_PREFIX}/bin/bash", "#{CREW_DEST_PREFIX}/bin/sh"
  end
  
  def self.postinstall
    puts
    puts "To complete the installation, execute the following:".lightblue
    puts "echo '# Make newer version of bash startup automatically' >> ~/.bashrc".lightblue
    puts "echo '#{CREW_PREFIX}/bin/sh' >> ~/.bashrc".lightblue
    puts "echo \"PS1=$PS1\" >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
