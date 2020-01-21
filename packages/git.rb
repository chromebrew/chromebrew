require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.25.0'
  source_url 'https://github.com/git/git/archive/v2.25.0.tar.gz'
  source_sha256 '99d336613ca3f1d689349330178e7ad67945aae206552905340ac8f4f904979d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.25.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.25.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.25.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.25.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa8607a7314095e4b164b80a38f2ce3d2fc38b20b94725f49144813e45a2528a',
     armv7l: 'fa8607a7314095e4b164b80a38f2ce3d2fc38b20b94725f49144813e45a2528a',
       i686: '45d03c624429a6b5948fb6344f737f37a3cdf149e06b75c4623d565a94314d3e',
     x86_64: '498fc3cafd8f23dff28480064c54c0da3d44a78541ea57bf4dbc584658f05aca',
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
