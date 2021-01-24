require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.30.0'
  version @_ver + '-1'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 '8db4edd1a0a74ebf4b78aed3f9e25c8f2a7db3c00b1aaee94d1e9834fae24e61'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '4386bc951eaa7311b8c828fb76b030410f63686c9c86f6288b2a1025594166f1',
      armv7l: '4386bc951eaa7311b8c828fb76b030410f63686c9c86f6288b2a1025594166f1',
        i686: '6dd0fc056dd3cdca76596603c1a161724e8f81d68c50bf18f25877e4df8dc9e4',
      x86_64: 'ae2a5001e272fdf4a1f212ed31f38b62e2fd20205f8ab0c77ab7226b8a94b6ac',
  })

  depends_on 'curl' => :build
  depends_on 'python3' => :build

  def self.build
    system 'autoreconf -i'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
    ./configure \
    --with-openssl=#{CREW_PREFIX}/etc/ssl \
    --without-tcltk #{CREW_OPTIONS} \
    --with-perl=#{CREW_PREFIX}/bin/perl \
    --with-python=#{CREW_PREFIX}/bin/python3 \
    --with-gitconfig=#{CREW_PREFIX}/etc/gitconfig \
    --with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
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
