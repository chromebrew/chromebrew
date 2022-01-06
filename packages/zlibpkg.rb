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
