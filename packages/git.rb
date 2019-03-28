require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.21.0'
  source_url 'https://github.com/git/git/archive/v2.21.0.tar.gz'
  source_sha256 '7a601275abcc6ff51cc79a6d402e83c90ae37d743b0b8d073aa009dd4b22d432'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.21.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.21.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.21.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.21.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b75f477d3831241a03dc72a130d64ca1755bb0cd8d8a56fac24940de6f12ae87',
     armv7l: 'b75f477d3831241a03dc72a130d64ca1755bb0cd8d8a56fac24940de6f12ae87',
       i686: '20e4a91ebace3b2d7f1744e80007cef5726a43b65b2a218c6ca0ab282e1333b8',
     x86_64: 'd3a74f5cb87e17c6108fd4a1fa297f34ce154f56301b63911ee3f603a0faa756',
  })

  depends_on 'curl' => :build
  depends_on 'python27' => :build     # requires python2

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
