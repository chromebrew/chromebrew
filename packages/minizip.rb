require 'package'
Package.load_package("#{__dir__}/zlib.rb")

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage Zlib.homepage
  version '1.4'
  # When upgrading minizip, be sure to upgrade zlib in tandem.
  puts "#{self} version differs from Zlib version #{Zlib.version.split('-').first}".orange if version != Zlib.version.split('-').first
  license Zlib.license
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{version}.tar.gz"
  source_sha256 '02dd159783677a749c04adbdd02b55b8a2bcc7e054f51b76b549199a916ad584'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4f874154d69b448af2f854f28fc256440279e791b97e3047e82fcc70280ef77',
     armv7l: 'b4f874154d69b448af2f854f28fc256440279e791b97e3047e82fcc70280ef77',
       i686: '89a4fc6a8208e5ad90c566cb4af6c20be813e871b621b94a03d55b80fcac14e1',
     x86_64: '9e45ee23080b9b4623cf535461eb09c6e5ac40deedd732f3bf0860428080c7dc'
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
