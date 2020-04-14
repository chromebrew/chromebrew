require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.26.0'
  source_url 'https://github.com/git/git/archive/v2.26.0.tar.gz'
  source_sha256 '2a93b9a3276464507922134bfba9be466427ab6a843e3773849050e3d05250d0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.26.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.26.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.26.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.26.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '41978feff6d8c94969475f97061cf6918f9a89c28d5b761bd0e58b5e74179708',
     armv7l: '41978feff6d8c94969475f97061cf6918f9a89c28d5b761bd0e58b5e74179708',
       i686: '50ffce89ffe648be451310404c8faf305c1e32c4259a49362b3f47a91c974c2b',
     x86_64: '7742e36511e15181cb076834a505b4d3cede3117986378b78015a83823a41b06',
  })

  depends_on 'curl' => :build
  depends_on 'python3' => :build
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
           "--with-python=#{CREW_PREFIX}/bin/python3",
           "--with-gitconfig=#{CREW_PREFIX}/etc/gitconfig",
           "--with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
    system "#{@make_cmd} all"
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
