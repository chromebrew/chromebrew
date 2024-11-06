require 'package'

class Fnotifystat < Package
  description 'Fnotifystat is a program that dumps the file system activity in a given period of time.'
  homepage 'https://github.com/ColinIanKing/fnotifystat'
  version '0.03.00'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/fnotifystat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2884561cd330aa452c5ca837cb925f28fb990d22c13963a1ac509432c6252ef9',
     armv7l: '2884561cd330aa452c5ca837cb925f28fb990d22c13963a1ac509432c6252ef9',
       i686: 'd076eb4e687b9199cca120c4e968229a290f005ff89dde02ab0d95e0ffec45d8',
     x86_64: '1d41056e556ad2f6b566bef8a0f9c3eeab413ed4a5ab448a58707e449030fa88'
  })

  def self.patch
    # Add support for overriding installation prefix in Makefile
    downloader 'https://patch-diff.githubusercontent.com/raw/ColinIanKing/fnotifystat/pull/2.patch', '6107417f16740bd0c4fcb94da52f04768e9987591a5cd6497be3368fd89a62c3'
    system 'git apply 2.patch'
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
