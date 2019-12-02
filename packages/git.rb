require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.24.0'
  source_url 'https://github.com/git/git/archive/v2.24.0.tar.gz'
  source_sha256 '6b96ba03bc9e3ae5b8fb32b4bd8546298bdd792995a5d4c87f1f92c3c08aedb5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.24.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.24.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.24.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.24.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6bc2c92505a198a56a1da26cb29d0ac94672ee7659efa32a14633ebf7a7a2915',
     armv7l: '6bc2c92505a198a56a1da26cb29d0ac94672ee7659efa32a14633ebf7a7a2915',
       i686: '426aae2dff8c2b0d19858b293c8e3ead63ba5040de8b0b29e9c6c659bd3173cd',
     x86_64: 'e2896c439c74afad22b01f022fead0ee9142abcf66c346059aa53acf97f526ab',
  })

  depends_on 'curl' => :build
  depends_on 'python27' => :build     # requires python2
  depends_on 'libiconv'

  # need to build using single core
  @make_cmd = 'make -j1'

  def self.build
    system 'autoreconf -i'
    system './configure',
           '--without-tcltk',
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
