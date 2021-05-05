require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.5-e7da'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/xz-mirror/xz.git'
  git_hashtag 'e7da44d5151e21f153925781ad29334ae0786101'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da_armv7l/xzutils-5.2.5-e7da-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da_armv7l/xzutils-5.2.5-e7da-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da_i686/xzutils-5.2.5-e7da-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da_x86_64/xzutils-5.2.5-e7da-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3b87b8150061f2f894f9ee69fceb6ab0b010fa9bdf63f79280c683eae28d588f',
     armv7l: '3b87b8150061f2f894f9ee69fceb6ab0b010fa9bdf63f79280c683eae28d588f',
       i686: 'a7da9276492788d722a0c853a81d8a5aff164eb16f49882514a1870d3f1397c7',
     x86_64: 'a3080d777b7f220b35e9c368925e3099796de08c292239c2c5ca117b9beeb859'
  })

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh --no-po4a'
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-docs \
      --enable-shared \
      --with-pic"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
