require 'package'
require_relative 'zlibpkg'

class Minizip < Package
  description 'Minizip is a simple package to zip/unzip files, from zlib.'
  homepage Zlibpkg.homepage
  @_ver = '1.2.13'
  version "#{@_ver}-1"
  # When upgrading minizip, be sure to upgrade zlibpkg in tandem.
  puts "#{self} version differs from Zlibpkg version #{Zlibpkg.version}".orange if version != Zlibpkg.version
  license Zlibpkg.license
  compatibility 'all'
  source_url Zlibpkg.source_url
  source_sha256 Zlibpkg.source_sha256

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.13_armv7l/minizip-1.2.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.13_armv7l/minizip-1.2.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.13_i686/minizip-1.2.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/minizip/1.2.13_x86_64/minizip-1.2.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7fd4d60ceddcc16766bf6cfa5249221da656d1a5420ed8c9d89b5105d4981e92',
     armv7l: '7fd4d60ceddcc16766bf6cfa5249221da656d1a5420ed8c9d89b5105d4981e92',
       i686: '691d10c6dfdd5eaed1cfcf711752618493b59d613947f405b9633ee0edf3fe37',
     x86_64: '74eea7645907e49beb344a748a3eec59684063c68070cd759898f259966550b7'
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
