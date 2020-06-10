require 'package'

class Libnftnl < Package
  description 'libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem.'
  homepage 'https://netfilter.org/projects/libnftnl/'
  version '1.1.1'
  compatibility 'all'
  source_url 'https://netfilter.org/projects/libnftnl/files/libnftnl-1.1.1.tar.bz2'
  source_sha256 '5d6a65413f27ec635eedf6aba033f7cf671d462a2afeacc562ba96b19893aff2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnftnl-1.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '98505655c55453a9f6bddddf1fd3f917ea3a98ed3f5e05f1fa609301fedb180c',
     armv7l: '98505655c55453a9f6bddddf1fd3f917ea3a98ed3f5e05f1fa609301fedb180c',
       i686: '0f1d6dca8c4dbf11856085d5572d45a66e86c422aeb278d68bd4c1e1af7c7675',
     x86_64: 'a0482c543920370b4fc428b50b48c4071efd60c2ecb83fdaae4d8e77bea70b92',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
