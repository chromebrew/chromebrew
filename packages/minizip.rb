require 'package'
require_relative 'zlibpkg'

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage Zlibpkg.homepage
  version '1.3.1'
  # When upgrading minizip, be sure to upgrade zlibpkg in tandem.
  puts "#{self} version differs from Zlibpkg version #{Zlibpkg.version}".orange if version != Zlibpkg.version
  license Zlibpkg.license
  compatibility 'all'
  source_url Zlibpkg.source_url
  source_sha256 Zlibpkg.source_sha256
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd905ac78dcf4be301c0b03cd68b1d98fdfd4607c50a6e118ecd823708691640a',
     armv7l: 'd905ac78dcf4be301c0b03cd68b1d98fdfd4607c50a6e118ecd823708691640a',
       i686: '42fddacd0c45d8a290068b369bb4037dae00356b7037b7a05f7f13984535aa9f',
     x86_64: 'fbdfaeb7561751925637c326da3e6a008cb65ce4918aff2151596d52058fa614'
  })

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
