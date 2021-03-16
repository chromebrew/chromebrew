require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.31.0'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 '13b3efb8eca3e3ef6e7eea6839600c37636dbac28069907beafd075ef7f45f0b'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.31.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.31.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.31.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git-2.31.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3eb7bfa293ab60c72ba430e81323979720d7d101413067d4df5fd64ed7ffcf83',
     armv7l: '3eb7bfa293ab60c72ba430e81323979720d7d101413067d4df5fd64ed7ffcf83',
       i686: '716d376ce2d8548d81ab2c88c3868e1eb8125dda656470509558b14b1bd5fbd5',
     x86_64: '287d1307cfd7a42be9f64e2acf98447e9d6b6b640905539b60e11533506fa507'
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
