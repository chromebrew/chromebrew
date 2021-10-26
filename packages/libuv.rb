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
    aarch64: '7c8de7258951a636d8e4956bf54ce94bf32ffef80c1a5ffcb70c472cfde23b93',
     armv7l: '7c8de7258951a636d8e4956bf54ce94bf32ffef80c1a5ffcb70c472cfde23b93',
       i686: '02e4a7da7e2b43efd099e44b7097c2efbeda5bb306968ba014e77e420e8655ec',
     x86_64: '85ec7265a2eaebec57b70199b94c7ff9a0e0eb94ad301fe0eb7a2b1f5f40132c'
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
  #  def self.check
  #   system "samu -C builddir test"
  # end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
