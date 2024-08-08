require 'package'
Package.load_package("#{__dir__}/zlib.rb")

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage Zlib.homepage
  version '1.3.1'
  # When upgrading minizip, be sure to upgrade zlib in tandem.
  puts "#{self} version differs from Zlib version #{Zlib.version.split('-').first}".orange if version != Zlib.version.split('-').first
  license Zlib.license
  compatibility 'all'
  source_url Zlib.source_url
  source_sha256 Zlib.source_sha256
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd905ac78dcf4be301c0b03cd68b1d98fdfd4607c50a6e118ecd823708691640a',
     armv7l: 'd905ac78dcf4be301c0b03cd68b1d98fdfd4607c50a6e118ecd823708691640a',
       i686: '42fddacd0c45d8a290068b369bb4037dae00356b7037b7a05f7f13984535aa9f',
     x86_64: 'fbdfaeb7561751925637c326da3e6a008cb65ce4918aff2151596d52058fa614'
  })

  depends_on 'zlib' # R

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
