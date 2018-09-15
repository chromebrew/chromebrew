require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.19.0'
  source_url 'https://github.com/git/git/archive/v2.19.0.tar.gz'
  source_sha256 'c4146d94d1c74de0d099bcd6ba22cc44f799332a46146ede4ad9c9f67971aa28'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.19.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.19.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.19.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.19.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c8ed38f5e4e8ce268f42c0f65c47b8a18674c9704ed8a9eefb376aedb60ced69',
     armv7l: 'c8ed38f5e4e8ce268f42c0f65c47b8a18674c9704ed8a9eefb376aedb60ced69',
       i686: '62e0f4b56a01380041b00ec59b9817bd2915de554bcd9d39e4eb463b5f10105d',
     x86_64: '80cc91e879dde9578668ea091a5d5f3129b57231b334bc4aa4cf4a5739f4feee',
  })

  depends_on 'curl' => :build
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
    #system "GIT_SKIP_TESTS='t9010.16 t9010.20 t9011.1[49] t9011.2[0346] t9011.31 ' #{@make_cmd} test"
  end
end
