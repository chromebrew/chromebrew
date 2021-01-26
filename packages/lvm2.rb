require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  @_ver = '2.03.11'
  version @_ver
  compatibility 'all'
  source_url "https://www.sourceware.org/pub/lvm2/releases/LVM2.#{@_ver}.tgz"
  source_sha256 '842c4510d4653990927d4518a5bf2743126a37531671a05842cdaf8d54bb9dd4'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.03.11-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.03.11-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.03.11-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lvm2-2.03.11-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a60be47b7f7011234587ebba6e28adb36d27138b4bb182aa88da8af7fc6a6079',
      armv7l: 'a60be47b7f7011234587ebba6e28adb36d27138b4bb182aa88da8af7fc6a6079',
        i686: '62fbf27d3a75a5bf043c02b24ecf4f55f428a14192a59289bb97fd14cd073d78',
      x86_64: 'd1b98a8b2c8ca75d78a4fd744a2d1aad44b0c23f102b588f8b5e7a7ed17d42c0',
  })
  
  depends_on 'libaio'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-selinux \
      --with-confdir=#{CREW_PREFIX}/etc"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
