require 'package'

class Gperf < Package
  description 'GNU gperf is a perfect hash function generator.'
  homepage 'https://www.gnu.org/software/gperf/'
  version '3.1'
  compatibility 'all'
  source_url 'http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz'
  source_sha256 '588546b945bba4b70b6a3a616e80b4ab466e3f33024a352fc2198112cdbb3ae2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gperf-3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gperf-3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gperf-3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gperf-3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4515671860504871812106df28e025e75ba47c8068d1183e2d9e2baf743c94d4',
     armv7l: '4515671860504871812106df28e025e75ba47c8068d1183e2d9e2baf743c94d4',
       i686: 'cc740abbac1d7bfff9886c0993a59bcbb5735cb7bcec09ab04a3c036cb3df2aa',
     x86_64: '50d2087a5d7c41451ba6320dd8614da47582e4a01b53a9be39041a4b0e10733b',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

