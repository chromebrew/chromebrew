require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.11'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '909483ca614a905c81b3f253ea91744bb8a05929237b0e3637daf04d10ad1698',
     armv7l: '909483ca614a905c81b3f253ea91744bb8a05929237b0e3637daf04d10ad1698',
       i686: '032036a9003bb3bbd8223621333f7d134539413a23140d08bab878a62dad2840',
     x86_64: 'd0cf7690608d2c7f671260c4f17cc92111ce898dccc2d80e2e9da296bd4502f8'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libtool' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'readline' # R
  depends_on 'unixodbc'

  def self.postinstall
    ExitMessage.add <<~EOM
      Edit the #{CREW_PREFIX}/etc/freetds.conf file to add servers.

      Test the connection with #{CREW_PREFIX}/bin/tsql.
    EOM
  end
end
