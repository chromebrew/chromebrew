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
    aarch64: '1dd507a336eee780e3919360cd434165251a2d86f7b11561357660903e8278de',
     armv7l: '1dd507a336eee780e3919360cd434165251a2d86f7b11561357660903e8278de',
       i686: '34ea7026b146354b7f8adcbbd10cfd3b477f954ad7c151edd5382dcafe76b8bf',
     x86_64: 'b1d8049921c59764d2173b0f83d73ba1328030442f2bf94ee55cdaee8457b76e'
  })

  depends_on 'glibc' => :library
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
  end
end
