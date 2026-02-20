require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.13'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c74b68890bf94d55ff5095d471fa4627d2d0b5b1f0a5d667e1d73d2d51bd9044',
     armv7l: 'c74b68890bf94d55ff5095d471fa4627d2d0b5b1f0a5d667e1d73d2d51bd9044',
       i686: '40148661363b3d67c54160a33c380ac103784749711a88752e5ed2057a1f0c46',
     x86_64: 'e6bfcba5057563bc3ba48ab5d24d50943f4f610b3a2ed5d60be8f2a4cf75ef82'
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
