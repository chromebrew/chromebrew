require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.16'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e793b1a1296c2f37dda39d3561737ae8fe481c8945020538b7d911b4b7c492c1',
     armv7l: 'e793b1a1296c2f37dda39d3561737ae8fe481c8945020538b7d911b4b7c492c1',
       i686: 'c55f59e544ef62897f2472e0c74ead550781de684f08accf11a37c8be4bf5de5',
     x86_64: '29b3cd48b2bc07f97eb83999d33ef57957d7e393ab8292cbc89927f8c8bc4e08'
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
