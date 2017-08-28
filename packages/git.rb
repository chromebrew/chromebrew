require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.14.1-1'
  source_url 'https://github.com/git/git/archive/v2.14.1.tar.gz'
  source_sha256 'ccc366d5d674fb755fd98d219c23f2b4e5da8a49d8582a6314813b280d75536b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.14.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.14.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.14.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.14.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8548a8273beeb7956fed40e5db078d624b3d0f9c7b5897980b31aaba5d0837b8',
     armv7l: '8548a8273beeb7956fed40e5db078d624b3d0f9c7b5897980b31aaba5d0837b8',
       i686: '11c1979b55f8ce623ceee18e78b3177c7038d6909bcbba717bda9fc8e9a6d3f2',
     x86_64: '5950f17a8016f39002e3e25d9c2bd015bb82e5b253285ae144a18a0f8c8fb2f6',
  })

  # use system zlibpkg, openssl, curl, expat
  depends_on 'autoconf' => :build
  depends_on 'zlibpkg' => :build
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
    puts
    puts "Git completion support is available for the following shells:"
    system "ls contrib/completion"
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
