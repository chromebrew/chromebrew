require 'package'

class Fslint < Package
  description 'FSlint is a utility to find and clean various forms of lint on a filesystem.'
  homepage 'http://www.pixelbeat.org/fslint/'
  version '2.46'
  compatibility 'all'
  source_url 'http://www.pixelbeat.org/fslint/fslint-2.46.tar.xz'
  source_sha256 'f15daebfecfd2eea0d3b48a0193e25974b71dcf1e4b4a33d5a3dcfb7bb9c90cc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fslint-2.46-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fslint-2.46-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fslint-2.46-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fslint-2.46-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2eb0a037b1b395589ad00bf857eb9eba17e9c30f1d1683417d7f00ef0854e50c',
     armv7l: '2eb0a037b1b395589ad00bf857eb9eba17e9c30f1d1683417d7f00ef0854e50c',
       i686: 'b0a8192b7ca71e2412533ea0c1e81db0532b15324472a9bf24125e023aee2ba3',
     x86_64: '5e3798a1ecaadb78deeaf1ac17bcafe842e72aac70247b9f95ccd915a5925460',
  })

  depends_on 'help2man'

  def self.build
    system 'rm -f man/*'
    system 'chmod +x fslint/supprt/fslver'
    system 'help2man -N fslint/findup > man/findup.1'
    system 'help2man -N fslint/findnl > man/findnl.1'
    system 'help2man -N fslint/findu8 > man/findu8.1'
    system 'help2man -N fslint/findbl > man/findbl.1'
    system 'help2man -N fslint/findsn > man/findsn.1'
    system 'help2man -N fslint/finded > man/finded.1'
    system 'help2man -N fslint/findid > man/findid.1'
    system 'help2man -N fslint/findns > man/findns.1'
    system 'help2man -N fslint/findrs > man/findrs.1'
    system 'help2man -N fslint/findtf > man/findtf.1'
    system 'help2man -N fslint/findul > man/findul.1'
    system 'help2man -N fslint/fslint > man/fslint.1'
    system 'help2man -N fslint/zipdir > man/zipdir.1'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "mkdir -p #{CREW_DEST_PREFIX}/man/man1"
    system "cp -r fslint/* #{CREW_DEST_PREFIX}/bin"
    system "cp fslint/fstool/lS #{CREW_DEST_PREFIX}/bin"
    system "cp man/* #{CREW_DEST_PREFIX}/man/man1"
  end
end
