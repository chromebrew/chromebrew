require 'package'

class Xzutils < Package
  description 'XZ Utils is free general-purpose data compression software with a high compression ratio.'
  homepage 'http://tukaani.org/xz/'
  version '5.2.5-e7da'
  license 'public-domain, LGPL-2.1+ and GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/xz-mirror/xz.git'
  git_hashtag 'e7da44d5151e21f153925781ad29334ae0786101'

  def self.build
    system '[ -x configure ] || ./autogen.sh'
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
