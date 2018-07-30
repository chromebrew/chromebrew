require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.18.0'
  source_url 'https://github.com/git/git/archive/v2.18.0.tar.gz'
  source_sha256 '93993babac690a06906d832a1715c3315b4787a2845aeb500f7dcc82e1599df2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4a0b4979ff300fe5562ace00e293139853104c9769a47c32ea895593f0cfe3d8',
     armv7l: '4a0b4979ff300fe5562ace00e293139853104c9769a47c32ea895593f0cfe3d8',
       i686: '51f5058681c87810bd25c2471e4d98353fecf54f1eefa6c172eaa0879e1a12bf',
     x86_64: 'a3dc5bf0bde8f3093f73a2f0413e1ad507cdb568d4f108258fb518ce7088831a',
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
