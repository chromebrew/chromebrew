require 'package'

class Fslint < Package
  description 'FSlint is a utility to find and clean various forms of lint on a filesystem.'
  homepage 'http://www.pixelbeat.org/fslint/'
  version '2.46'
  source_url 'http://www.pixelbeat.org/fslint/fslint-2.46.tar.xz'
  source_sha256 'f15daebfecfd2eea0d3b48a0193e25974b71dcf1e4b4a33d5a3dcfb7bb9c90cc'

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
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp -r fslint/* #{CREW_DEST_DIR}/usr/local/bin"
    system "cp fslint/fstool/lS #{CREW_DEST_DIR}/usr/local/bin"
    system "cp man/* #{CREW_DEST_DIR}/usr/local/man/man1"
  end
end
