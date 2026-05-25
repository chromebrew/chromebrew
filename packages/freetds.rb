require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d7e87f8aa71ee22ec42a13a8fbafcd8f07ae691b32e2e0d520b06218d871b01',
     armv7l: '9d7e87f8aa71ee22ec42a13a8fbafcd8f07ae691b32e2e0d520b06218d871b01',
       i686: '847c5a856c52143b0cbe70a6646fc9ee320d56450e1008db9d718ec52cd8d0d8',
     x86_64: 'bd2adaa5558f7a46d1d4e03c4a07df4f5c1468cdbdc11c6131d56ec7d5059cac'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gperf' => :build
  depends_on 'libtool' => :library
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
