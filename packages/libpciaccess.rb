require 'package'

class Libpciaccess < Package
  description 'Generic PCI access library'
  homepage 'https://x.org'
  version '0.16'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libpciaccess-0.16.tar.gz'
  source_sha256 '84413553994aef0070cf420050aa5c0a51b1956b404920e21b81e96db6a61a27'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.16-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.16-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpciaccess-0.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4168d9adea96e7394c3a2aee9b732134abf9ea0c749dcf1b696bbb2d19047bec',
     armv7l: '4168d9adea96e7394c3a2aee9b732134abf9ea0c749dcf1b696bbb2d19047bec',
       i686: 'ad555204d597c0600daeecf298240e072cdfd12b7b0a6674ca5e8cbc9f27b5eb',
     x86_64: '1d1a2bcf5767f35e3502681aa2821fd9f81b3bf517f595657c22296163219a14',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
