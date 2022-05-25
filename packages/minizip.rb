require 'package'
require_relative 'zlibpkg'

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage Zlibpkg.homepage
  version '1.3'
  # When upgrading minizip, be sure to upgrade zlibpkg in tandem.
  puts "#{self} version differs from Zlibpkg version #{Zlibpkg.version}".orange if version != Zlibpkg.version
  license Zlibpkg.license
  compatibility 'all'
  source_url Zlibpkg.source_url
  source_sha256 Zlibpkg.source_sha256
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.3_armv7l/minizip-1.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.3_armv7l/minizip-1.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.3_i686/minizip-1.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.3_x86_64/minizip-1.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9a789d1f8f2119e3f4e79ca6a7311a5df8c524c0690f7e15319691c6a60fc3ff',
     armv7l: '9a789d1f8f2119e3f4e79ca6a7311a5df8c524c0690f7e15319691c6a60fc3ff',
       i686: '194f8f1a9f7ac94b202926b3b5da3780d734f3586167750cb725f5d3a5f194f0',
     x86_64: '19b5affc8be85b051f70039b4007088a23d00cea7bead6c4512b89134a493177'
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
