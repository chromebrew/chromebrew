require 'package'

class Ndisc6 < Package
  description 'Small collection of useful tools for IPv6 networking (ndisc6, rdisc6, tcptraceroute6, traceroute6, rdnssd).'
  homepage 'https://www.remlab.net/ndisc6/'
  version '1.0.4'
  compatibility 'all'
  source_url 'https://www.remlab.net/files/ndisc6/ndisc6-1.0.4.tar.bz2'
  source_sha256 'abb1da4a98d94e5abe1dd7b1c975de540306b0581cbbd36aff035118b2f25c1f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ndisc6-1.0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ndisc6-1.0.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ndisc6-1.0.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ndisc6-1.0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5a9f7557dd481117483f81035f168a8c0de9a2210c57b049219727f6546fc2b1',
     armv7l: '5a9f7557dd481117483f81035f168a8c0de9a2210c57b049219727f6546fc2b1',
       i686: 'b2d727341b6a5302dda0da0529635b11cc4e04a1ca1e8eb129ab53bafae17a0f',
     x86_64: '2fe334ddc96bd956663ceb593383800e9d8216fb867beadd5ecb099d41504148',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-suid-install"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
