require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.03.19'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/lvm2.git'
  git_hashtag "v#{version.gsub('.', '_')}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.19_armv7l/lvm2-2.03.19-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.19_armv7l/lvm2-2.03.19-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.19_i686/lvm2-2.03.19-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.19_x86_64/lvm2-2.03.19-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '66310aeb86c3cd74f561202b8c56fa26fe9e14795c2bd0c2c661fc9ecef47497',
     armv7l: '66310aeb86c3cd74f561202b8c56fa26fe9e14795c2bd0c2c661fc9ecef47497',
       i686: '00a31956da2b6c85c1d11bd5b175cabbc91772a86d3f9ff9c02121d03064e6c8',
     x86_64: 'e814c5e0e9859fd55634bec5a7ca3c7231b2ef017faa52e09b685c2ae89355e8'
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
