require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  @_ver = '1.39.0'
  version @_ver
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{@_ver}/libuv-v#{@_ver}.tar.gz"
  source_sha256 '5c52de5bdcfb322dbe10f98feb56e45162e668ad08bc28ab4b914d4f79911697'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.39.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.39.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.39.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.39.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4b844ba4a96f39e12b4a691c96d76726de85ced70ca4eda8dcc5f6f02fc56b13',
     armv7l: '4b844ba4a96f39e12b4a691c96d76726de85ced70ca4eda8dcc5f6f02fc56b13',
       i686: '49ad521137cca7a9384d84f3bf88b232edabf9ad9e26f40d1c543ea6975ed5ce',
     x86_64: '49f142a0b9e09c4b48a6d9dbac1b20fb2e579536af9391d04c06fb0ef9693844'
  })

  def self.build
    system './autogen.sh'
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
