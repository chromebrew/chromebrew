require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.03.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/lvm2.git'
  git_hashtag "v#{version.gsub('.', '_')}"

  binary_url({
     aarch64: 'file:///usr/local/tmp/packages/lvm2-2.03.18-chromeos-armv7l.tar.zst',
      armv7l: 'file:///usr/local/tmp/packages/lvm2-2.03.18-chromeos-armv7l.tar.zst',
        i686: 'file:///usr/local/tmp/packages/lvm2-2.03.18-chromeos-i686.tar.zst',
      x86_64: 'file:///usr/local/tmp/packages/lvm2-2.03.18-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
     aarch64: 'd9505883f72c0ad509c453c81b1489f46bd90704486e6ad5850905329ff4281e',
      armv7l: 'd9505883f72c0ad509c453c81b1489f46bd90704486e6ad5850905329ff4281e',
        i686: 'b25d5d6fe3efb61b9c3355d699e2cb7c076497925dc3125ee3019dabd474bd1c',
      x86_64: '6dfd9b44c1b7fae9e5bea128a278091b225dd626fb112169519f0541bfeb4d81'
  })

  depends_on 'glibc' # R
  depends_on 'libaio' # R
  depends_on 'readline' # R
  depends_on 'util_linux' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --localstatedir=#{CREW_PREFIX}/var \
      --disable-selinux \
      --enable-cmdlib \
      --enable-dmeventd \
      --enable-pkgconfig \
      --enable-readline \
      --with-cache=internal \
      --with-thin=internal \
      --with-confdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
