require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'https://libuv.org/'
  @_ver = '1.42.0'
  version @_ver
  license 'BSD, BSD-2, ISC and MIT'
  compatibility 'all'
  source_url "https://dist.libuv.org/dist/v#{@_ver}/libuv-v#{@_ver}.tar.gz"
  source_sha256 '43129625155a8aed796ebe90b8d4c990a73985ec717de2b2d5d3a23cfe4deb72'

  def self.build
    system './autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
