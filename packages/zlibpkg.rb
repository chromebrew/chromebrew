require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  # When upgrading zlibpkg, be sure to upgrade minizip in tandem.
  @_ver = '1.2.11'
  version "#{@_ver}-6"
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-6_armv7l/zlibpkg-1.2.11-6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-6_armv7l/zlibpkg-1.2.11-6-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-6_i686/zlibpkg-1.2.11-6-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-6_x86_64/zlibpkg-1.2.11-6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0012a9c80b2c224cd51556b14cfd52095559a38aaca25a943164e5a1bff04488',
     armv7l: '0012a9c80b2c224cd51556b14cfd52095559a38aaca25a943164e5a1bff04488',
       i686: '2c1fbea91e0287064e7a5323b5298af74dc5ae29ee53cb9636e90c7c4842c8d3',
     x86_64: '6a213888ddd3ff584c8f354a107fdf00f11b8570b5a5dac909a95bc4c165a0cd'
  })

  def self.build
    # Build zlib proper
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    # Install zlib
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
