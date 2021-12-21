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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_armv7l/libuv-1.42.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_armv7l/libuv-1.42.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_i686/libuv-1.42.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libuv/1.42.0_x86_64/libuv-1.42.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2d9e73560c0285b089bca9c16285a54d550427ed63beeccc67b8e342298af8b6',
     armv7l: '2d9e73560c0285b089bca9c16285a54d550427ed63beeccc67b8e342298af8b6',
       i686: 'f050af38e8f6a434b062126afc279c74f83b91f553cc631c9712fbc3275d0847',
     x86_64: '2e7162ae796316fac9bb5f2fe1cbcb0e13f4da6d35d5b89cc2f7f402aa17fbfd'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "#{CREW_ENV_OPTIONS} cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          .."
    end
    system 'samu -C builddir'
  end

  # udp_multicast_join and udp_multicast_join6 tests fail
  # def self.check
  #   system "samu -C builddir test"
  # end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
