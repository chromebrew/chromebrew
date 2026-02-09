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
    aarch64: 'd70536c5683c9cc2d7f07220f6278c01648dda440e464dec9fd5d409bb03347d',
     armv7l: 'd70536c5683c9cc2d7f07220f6278c01648dda440e464dec9fd5d409bb03347d',
       i686: 'be60393833e99d33e80048b11f6199474dd6813f45951499debdf255bf9d2778',
     x86_64: 'eaf110473d348b8ef7a23db910f63c011a56252c0f6b42f3b4adac470062710b'
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
