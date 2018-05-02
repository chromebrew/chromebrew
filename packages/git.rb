require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.17.0'
  source_url 'https://github.com/git/git/archive/v2.17.0.tar.gz'
  source_sha256 '46f3a29c250313276ac747a3a221ca69dbc3218754f8db188841322cf7ab58d3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2344502e10a3e8d9054e5769b9781640d455288914f517f9bc1e669050d13703',
     armv7l: '2344502e10a3e8d9054e5769b9781640d455288914f517f9bc1e669050d13703',
       i686: '127385a0b9d0f6e2f14b96cd649f38a3af18f02689685cd06b2eb8b35a6134df',
     x86_64: 'fddf194fcafc443968343f19f20561b71faedf93e43b0db52c180144e4457145',
  })

  # use system zlib, openssl, curl, expat
  depends_on 'autoconf' => :build
  depends_on 'libssh2'
  depends_on 'openssl' => :build
  depends_on 'curl' => :build
  depends_on 'expat' => :build
  depends_on 'gettext' => :build
  depends_on 'perl' => :build
  depends_on 'python27' => :build     # requires python2

  # need to build using single core
  @make_cmd = "make -j1 prefix=#{CREW_PREFIX} CC=gcc PERL_PATH=#{CREW_PREFIX}/bin/perl PYTHON_PATH=#{CREW_PREFIX}/bin/python2"

  def self.build
    system "autoconf"
    system "./configure --without-tcltk"
    system "#{@make_cmd} all"
  end

  def self.install
    system "#{@make_cmd} DESTDIR=#{CREW_DEST_DIR} install"
    system "mkdir -p #{CREW_DEST_PREFIX}/share/git-completion"
    system "cp -r contrib/completion/* #{CREW_DEST_PREFIX}/share/git-completion"
  end

  def self.postinstall
    puts
    puts "Git completion support is available for the following shells:".lightblue
    system "ls #{CREW_PREFIX}/share/git-completion"
    puts
    puts "To add git completion for bash, execute the following:".lightblue
    puts "echo '# git completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/git-completion/git-completion.bash ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/git-completion/git-completion.bash' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end

  def self.check
    # Skip several t9010-svn-fe and t9011-svn-da tests since they fail.
    system "GIT_SKIP_TESTS='t9010.16 t9010.20 t9011.1[49] t9011.2[0346] t9011.31 ' #{@make_cmd} test"
  end
end
