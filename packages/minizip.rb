require 'package'

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage 'https://www.zlib.net/'
  @_ver = '1.2.11'
  # When upgrading minzip, be sure to upgrade zlibpkg in tandem.
  version @_ver
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  depends_on 'zlibpkg'

  def self.build
    Dir.chdir 'contrib/minizip' do
      system 'autoreconf -fiv'
      system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-demos"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'contrib/minizip' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
