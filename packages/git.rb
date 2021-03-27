require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.31.0'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 '13b3efb8eca3e3ef6e7eea6839600c37636dbac28069907beafd075ef7f45f0b'

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

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # git bash completion
      source #{CREW_PREFIX}/share/git-completion/git-completion.bash
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/git", @env)
  end
end
