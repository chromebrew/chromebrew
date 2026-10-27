require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.20'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac03f844c50d59280ad6e508f807c22a1846668d54f7dd4982bab3974173a56a',
     armv7l: 'ac03f844c50d59280ad6e508f807c22a1846668d54f7dd4982bab3974173a56a',
       i686: 'f37024f272aec82a04c84b46a02bed0754fb40a0f5f67733cecadc18798f26fc',
     x86_64: 'f246084b679a99c4b35e643ff34025015c20b1fb3ff0b6acdbf1236d1bad885c'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gperf' => :build
  depends_on 'libtool' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :library
  depends_on 'readline' => :executable
  depends_on 'unixodbc' => :library

  def self.prebuild
    system 'autoreconf -fiv'
  end

  def self.postinstall
    ExitMessage.add <<~EOM
      Edit the #{CREW_PREFIX}/etc/freetds.conf file to add servers.

      Test the connection with #{CREW_PREFIX}/bin/tsql.
    EOM
  end
end
