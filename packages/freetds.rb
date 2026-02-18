require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.12'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4d64b742ad70e8440a4652a9ad9a5eebd3e903325b5d53dc1d1c10f7ac93358',
     armv7l: 'a4d64b742ad70e8440a4652a9ad9a5eebd3e903325b5d53dc1d1c10f7ac93358',
       i686: '62ca1bcb413ea952cdab15bbfa8dc41b51a2356cf59bf7fe697c28a8c4d6e024',
     x86_64: '45a4367acb1a0d7f4023a81da319af7b1443e1c1ab956eeda5db20ca1d82ff99'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libtool' # R
  depends_on 'ncurses' => :executable_only
  depends_on 'openssl' # R
  depends_on 'readline' => :executable_only
  depends_on 'unixodbc' # R

  def self.postinstall
    ExitMessage.add <<~EOM
      Edit the #{CREW_PREFIX}/etc/freetds.conf file to add servers.

      Test the connection with #{CREW_PREFIX}/bin/tsql.
    EOM
  end
end
