require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.5-e7da-1'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/xz-mirror/xz.git'
  git_hashtag 'e7da44d5151e21f153925781ad29334ae0786101'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da-1_armv7l/xzutils-5.2.5-e7da-1-chromeos-armv7l.tar.xz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da-1_armv7l/xzutils-5.2.5-e7da-1-chromeos-armv7l.tar.xz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da-1_i686/xzutils-5.2.5-e7da-1-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xzutils/5.2.5-e7da-1_x86_64/xzutils-5.2.5-e7da-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4caa279bff570ecefe1fa84519dec7ec66d55bec943eee7ec94a8274d7c8e620',
    armv7l: '4caa279bff570ecefe1fa84519dec7ec66d55bec943eee7ec94a8274d7c8e620',
    i686: '853236ac1097893128530ab257f59a3e0c430a886be495e3129917da85ac1060',
    x86_64: '3dc20e0ee9d0a08c43c61ab4cced5c497ffafd9ab1d46f9ec50ff8969e98dfe0'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R

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
