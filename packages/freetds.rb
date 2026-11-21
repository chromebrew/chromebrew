require 'buildsystems/autotools'

class Freetds < Autotools
  description 'FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases.'
  homepage 'https://www.freetds.org/'
  version '1.5.22'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/FreeTDS/freetds.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c46bbe7e79451387c78ba310874578f83a108b522b0ec7aab7c012c65d79e8c5',
     armv7l: 'c46bbe7e79451387c78ba310874578f83a108b522b0ec7aab7c012c65d79e8c5',
       i686: '3e954dbbd23e70fef50452465d4e774beef6e782129e2e75fd205a2e2ad18da5',
     x86_64: 'f0a0d27d2de5b3dd2e54bf4825f32bca16b5d06875f9e576aef7d2b4a3c752d3'
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
