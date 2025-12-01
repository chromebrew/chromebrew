require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.10'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'gperf' => :build
  depends_on 'unixodbc'

  def self.postinstall
    ExitMessage.add <<~EOM
      Edit the #{CREW_PREFIX}/etc/freetds.conf file to add servers.

      Test the connection with #{CREW_PREFIX}/bin/tsql.
    EOM
  end
end
