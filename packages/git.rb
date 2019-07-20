require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.22.0'
  source_url 'https://github.com/git/git/archive/v2.22.0.tar.gz'
  source_sha256 'd2557e9d6a90819cca463b7f2a7b30fd62d8ccc9760c8453f078e936559cb017'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.22.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.22.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.22.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.22.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1e52aff31745a6ad134e807f151e8e6fd519bdd69c2f5ec9069661f7c66561a2',
     armv7l: '1e52aff31745a6ad134e807f151e8e6fd519bdd69c2f5ec9069661f7c66561a2',
       i686: '11d522ecb99eb1ddb78166f30a635012107e6688da1c686263a4135dbf928dcd',
     x86_64: 'ce8aee90b5d8c477d12f9e99f541180375aaf5af2d4e9c2b8a2598d2d8e53565',
  })

  depends_on 'curl' => :build
  depends_on 'python27' => :build     # requires python2
  depends_on 'libiconv'

  # need to build using single core
  @make_cmd = "make -j1"

  def self.build
    system "autoreconf -i"
    system "./configure",
           "--without-tcltk",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-perl=#{CREW_PREFIX}/bin/perl",
           "--with-python=#{CREW_PREFIX}/bin/python2",
           "--with-gitconfig=#{CREW_PREFIX}/etc/gitconfig",
           "--with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
    system "#{@make_cmd} all"
  end

  def self.install
    system "#{@make_cmd} DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    system "cp -a contrib/completion/. #{CREW_DEST_PREFIX}/share/git-completion/"
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
end
