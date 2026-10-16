require 'package'
Package.load_package("#{__dir__}/zlib.rb")

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage Zlib.homepage
  version '1.3.2'
  # When upgrading minizip, be sure to upgrade zlib in tandem.
  puts "#{self} version differs from Zlib version #{Zlib.version.split('-').first}".orange if version != Zlib.version.split('-').first
  license Zlib.license
  compatibility 'all'
  source_url Zlib.source_url
  source_sha256 Zlib.source_sha256
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '576b613ef0f13e400062847c8de1c35d52153b6fad0cda5160975c9eb1e1f619',
     armv7l: '576b613ef0f13e400062847c8de1c35d52153b6fad0cda5160975c9eb1e1f619',
       i686: 'fd83b3b7c69a144711373b0bc35c3868c564efe240bfbc00754ecb9e37fb0a81',
     x86_64: '5aac1c5f064bbafd0aa29415cb597f81d10e200fe3669a4add6b7412202e8fce'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  def self.build
    Dir.chdir 'contrib/minizip' do
      system 'autoreconf -fiv'
      system "./configure #{CREW_CONFIGURE_OPTIONS} \
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
    # Remove conflict with libxcrypt.
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/include/crypt.h"
  end
end
