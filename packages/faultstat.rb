require 'package'

class Faultstat < Package
  description 'Faultstat measures page fault activity and swap utilization of processes'
  homepage 'https://github.com/ColinIanKing/faultstat'
  version '0.01.11'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/ColinIanKing/faultstat.git'
  git_hashtag "V#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '107d40e974c26833b74828cefdf50d24626f3bfa2d33d4b55d95a5b989c18ce8',
     armv7l: '107d40e974c26833b74828cefdf50d24626f3bfa2d33d4b55d95a5b989c18ce8',
       i686: '373a96ee73bfdec3545a1af4a1218bf5d662b2c889b0c2ff40c6f3958cb70212',
     x86_64: '13512f8bf0d1789ba1478eedeec8c764c2a0e8fd0bd6c6029f695298ada43a96'
  })

  depends_on 'ncurses' # R

  def self.patch
    # Add support for overriding installation prefix in Makefile
    Downloader.download 'https://patch-diff.githubusercontent.com/raw/ColinIanKing/faultstat/pull/6.patch', 'fe1c1faf89908646f32ece035ff74330560f34b1f0f236f9888d7f04df609210'
    system 'git apply 6.patch'
  end

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses make"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
