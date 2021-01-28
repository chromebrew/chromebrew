require 'package'

class Bash < Package
  description 'The Bourne Again SHell'
  homepage 'https://www.gnu.org/software/bash/'
  version '5.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/bash/bash-5.1.tar.gz'
  source_sha256 'cc012bc860406dcf42f64431bcd3d2fa7560c02915a601aba9cd597a39329baa'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bash-5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'b2af2966a519ae1575ac142ea44f9884dd1bb00648f04c123e605368550568d1',
      armv7l: 'b2af2966a519ae1575ac142ea44f9884dd1bb00648f04c123e605368550568d1',
        i686: '0c28792af122162259e8d0069e0eaf7709336b32358fc765f0e11df7faaac4c1',
      x86_64: 'f313ac9ef7294303e75db4bb4fbc26a12346825498f772c8c672cab71e23a460',
  })

  depends_on 'llvm' => :build # Needed only for lld, which appears to allow linking libiconv where ld does not.
  depends_on 'ncurses' => :build # A static enabled ncurses build w/o "--without-normal" is required to build.

  case ARCH
  when 'i686'
  @CONFIGUREFLAGS = '--without-bash-malloc'
  when 'aarch64','armv7l','x86_64'
  @CONFIGUREFLAGS = '--with-bash-malloc'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} #{@CONFIGUREFLAGS} --with-curses --enable-readline \
      --enable-mem-scramble --enable-usg-echo-default \
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
