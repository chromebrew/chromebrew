require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.17.1'
  source_url 'https://github.com/git/git/archive/v2.17.1.tar.gz'
  source_sha256 '690f12cc5691e5adaf2dd390eae6f5acce68ae0d9bd9403814f8a1433833f02a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.17.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8f13dc48bae374a359de16f564357d2d7a350061734be7f6807ef2bf64a1ca2',
     armv7l: 'd8f13dc48bae374a359de16f564357d2d7a350061734be7f6807ef2bf64a1ca2',
       i686: '303eaede71c14030740054db083d0c182b923e22f12bb39101821b093eaacb0e',
     x86_64: '797ed11ae67ffaf1ba0c5019d10270c0b6a880f40b8c89cb2da98c7fa17cae1d',
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
    system "GIT_SKIP_TESTS='t9010.16 t9010.20 t9011.1[49] t9011.2[0346] t9011.31 ' #{@make_cmd} test"
  end
end
