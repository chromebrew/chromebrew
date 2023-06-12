require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.03.21'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/lvm2.git'
  git_hashtag "v#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.21_armv7l/lvm2-2.03.21-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.21_armv7l/lvm2-2.03.21-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.21_i686/lvm2-2.03.21-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.21_x86_64/lvm2-2.03.21-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ef5982aaa3ecf3e5fb2efd64471416ae19dc51d6b56335a227b25af531b0d723',
     armv7l: 'ef5982aaa3ecf3e5fb2efd64471416ae19dc51d6b56335a227b25af531b0d723',
       i686: '313cbd09c6eaec4ef629c564bdb3fce173787d09d510d77890211258cf54d256',
     x86_64: 'ce91944b598cc53ffc40180506c8351ce0954b1d2da38104a23004fdcbaf8f35'
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
