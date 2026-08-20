require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.19'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c464a384c13c61fc9f65199d95f348dbfd58aeac47ea1eb7367e1baa0b3a68d4',
     armv7l: 'c464a384c13c61fc9f65199d95f348dbfd58aeac47ea1eb7367e1baa0b3a68d4',
       i686: 'b6fd5ed80c0674e0bf435beb7138033b6e4b9af108e3763c993a26b52b391449',
     x86_64: '63add551137fe6357fcc028a083400dcf950e2a4ac8b63444e8e5a8bd7a6adbf'
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
