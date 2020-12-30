require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  version '2.29.2'
  compatibility 'all'
  source_url 'https://github.com/git/git/archive/v2.29.2.tar.gz'
  source_sha256 '8cc15abf2bc1cfa4b8acc37025cf92ec73c20efdb3f243793fef71dfe87478be'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.29.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '892ed67dfc19d0f5056836d3a707c1f4d5717bdf82e0d6d0facd11f9eb964fa4',
      armv7l: '892ed67dfc19d0f5056836d3a707c1f4d5717bdf82e0d6d0facd11f9eb964fa4',
        i686: '45af562bfd02b45839a92e5b14f67c267b5ddf60a526828b9a0567750d8eb085',
      x86_64: '652c8df51f2862f15e60f4e01e9308d25c5d7944cf51f7bd9a6dc922e7366a82',
  })

  depends_on 'curl' => :build
  depends_on 'python3' => :build

  def self.build
    system 'autoreconf -i'
    system "./configure \
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
