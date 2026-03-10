require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.14'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c37929c92136d3eff6c560aa245d7e82e8165986e5ebe040989d7720e63eaf6',
     armv7l: '2c37929c92136d3eff6c560aa245d7e82e8165986e5ebe040989d7720e63eaf6',
       i686: '4b737bf0e3fb16a8b9012154a48528d58286f70d5671f22b8da9ccd5f78c5caa',
     x86_64: 'aa68c5815ca66fe619c31d91385e373450fda486bf15e26adbae613fa8f6d08e'
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
