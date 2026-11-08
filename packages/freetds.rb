require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.21'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8641da817f2f8a08d4368c91e60b5874683cd5f55a701d6ecca7b1fdab24fd0',
     armv7l: 'a8641da817f2f8a08d4368c91e60b5874683cd5f55a701d6ecca7b1fdab24fd0',
       i686: '55cd86ae27b4d8c8e2c0679823f22848a271d5213e6352ac99807ea05a9722e8',
     x86_64: 'fb84e7fd86d414415e5d71ab45f7f722cbb5e433d601ee9237fc9bc7e9fd4beb'
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
