require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.30.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 '8db4edd1a0a74ebf4b78aed3f9e25c8f2a7db3c00b1aaee94d1e9834fae24e61'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '530242b602699db7a4f649c47ec44e81586128629b24b3e7fb7e1a9f877e8353',
      armv7l: '530242b602699db7a4f649c47ec44e81586128629b24b3e7fb7e1a9f877e8353',
        i686: 'fa19e5276870d4347259daf6b8c4c001eafdaabb0c02b7846014558cf6ca90a5',
      x86_64: '70adb89d9f1e1a250cc84f0e1b3e98d7ed5c82ceb413f4ae451ef9cd748b9398',
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
