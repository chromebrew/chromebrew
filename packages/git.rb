require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.30.0'
  version "#{@_ver}-2"
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 '8db4edd1a0a74ebf4b78aed3f9e25c8f2a7db3c00b1aaee94d1e9834fae24e61'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a11bad34ddd17924b226026eccabf449381cf6b069715b914ab7bd66b3190a36',
     armv7l: 'a11bad34ddd17924b226026eccabf449381cf6b069715b914ab7bd66b3190a36',
       i686: 'd09ad3f842c1fefba128e28252d383b69bc890627e7759abeb1d75b624bf4d84',
     x86_64: '3a63be93d3bbc46811a7f8b81a8e4b08c03ff82facf36419030ac214b60e4e6b'
  })

  depends_on 'curl' => :build
  depends_on 'python3' => :build

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system 'autoreconf -i'
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
    LDFLAGS='-flto=auto' \
    ./configure \
    #{CREW_OPTIONS} \
    --with-openssl=#{CREW_PREFIX}/etc/ssl \
    --without-tcltk \
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
    puts 'Git completion support is available for the following shells:'.lightblue
    system "ls #{CREW_PREFIX}/share/git-completion"
    puts
    puts 'To add git completion for bash, execute the following:'.lightblue
    puts "echo '# git completion' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/git-completion/git-completion.bash ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/git-completion/git-completion.bash' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
  end
end
