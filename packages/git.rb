require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.23.0'
  source_url 'https://github.com/git/git/archive/v2.23.0.tar.gz'
  source_sha256 '7d84f5d6f48e95b467a04a8aa1d474e0d21abc7877998af945568d2634fea46a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.23.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b89d3e83fe9c797c69b4ec90c6f88004270437fbdd4fd378a6a31d66ee7cb276',
     armv7l: 'b89d3e83fe9c797c69b4ec90c6f88004270437fbdd4fd378a6a31d66ee7cb276',
       i686: 'b02bb5d57315a2c620ecf177ac19fdadf03139136d7bc864e86b08d26e08472b',
     x86_64: 'a67df6819289a4acb87e07c9f84300c1856c9116691318bf440cab7f8eb044e6',
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
