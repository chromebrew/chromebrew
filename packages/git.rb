require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.29.1'
  compatibility 'all'
  source_url 'https://github.com/git/git/archive/v2.29.1.tar.gz'
  source_sha256 'ba2c36747abd2f07ed8ba61481cbb2290188f7a784d5d6ba2a052b56b139dd9f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34d1b4b333195d6aaf5856665dbd9a8b56152603e93fd85f36a1b9c69de8852a',
     armv7l: '34d1b4b333195d6aaf5856665dbd9a8b56152603e93fd85f36a1b9c69de8852a',
       i686: '0246035512a9cd81206672ccb996b97a1252050e9473340278c324988ca90b6d',
     x86_64: 'b850298e9dbbbcc9777d8fff1c95bcf701f26124780fa9976c6dd4381bcc204a',
  })

  depends_on 'curl' => :build
  depends_on 'python3' => :build
  depends_on 'libiconv'

  def self.build
    system 'autoreconf -i'
    system "./configure --with-openssl=#{CREW_PREFIX}/etc/ssl --without-tcltk #{CREW_OPTIONS} --with-perl=#{CREW_PREFIX}/bin/perl --with-python=#{CREW_PREFIX}/bin/python3 \
--with-gitconfig=#{CREW_PREFIX}/etc/gitconfig --with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
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
