require 'package'
require_relative 'zlibpkg'

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage Zlibpkg.homepage
  @_ver = '1.2.13'
  # When upgrading minzip, be sure to upgrade zlibpkg in tandem.
  version Zlibpkg.version
  license Zlibpkg.license
  compatibility 'all'
  source_url Zlibpkg.source_url
  source_sha256 Zlibpkg.source_sha256

  depends_on 'zlibpkg' # R

  def self.build
    Dir.chdir 'contrib/minizip' do
      system 'autoreconf -fiv'
      system "./configure #{CREW_OPTIONS} \
                --enable-demos"
      system 'make'
    end
  end

  def self.check
    Dir.chdir 'contrib/minizip' do
      system 'make', 'check'
    end
  end

  def self.install
    Dir.chdir 'contrib/minizip' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
