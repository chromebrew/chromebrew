require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.30.2'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 'e637ff90a3465e519885c8c4b7a67657ab0b7b1820e9324d12e50ec2e38e4d0b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.30.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '39c9142966a13196150404b95b93b2af004ce401f3ccca3d0bf003ea1e9fe09d',
     armv7l: '39c9142966a13196150404b95b93b2af004ce401f3ccca3d0bf003ea1e9fe09d',
       i686: '7dcd6f9fe632576ae612b1bd15d58095d2c84902e26778b9420ce53c209144f7',
     x86_64: '8fe8c1efe61a6da43434713e8e61f9ca411930f10c47983d4dcbbedface26393'
  })

  def self.build
    abort('Please remove libiconv before building.') if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

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
