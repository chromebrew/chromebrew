require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.26.0'
  compatibility 'all'
  source_url 'https://github.com/git/git/archive/v2.28.0.tar.gz'
  source_sha256 '02016d16dbce553699db5c9c04f6d13a3f50727c652061b7eb97a828d045e534' 

  depends_on 'curl' => :build
  depends_on 'python3' => :build
  depends_on 'libiconv'

  def self.build
    system 'autoreconf -i'
    system "./configure --without-tcltk #{CREW_OPTIONS} --with-perl=#{CREW_PREFIX}/bin/perl --with-python=#{CREW_PREFIX}/bin/python3 \ 
--with-gitconfig=#{CREW_PREFIX}/etc/gitconfig --with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
    system 'make'
  end

  def self.install
    system "#{@make_cmd} DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    FileUtils.cp_r Dir.glob('contrib/completion/.'), "#{CREW_DEST_PREFIX}/share/git-completion/"
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
