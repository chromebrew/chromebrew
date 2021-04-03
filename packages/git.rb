require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.31.1'
  version "#{@_ver}"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 'b1c0e95e9861b5d1b9ad3d8deaa2d8c7f02304ffc1b5e8869dd9fb98f9a0d436'

  def self.build
    abort('Please remove libiconv before building.') if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system 'autoreconf -fiv'
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
