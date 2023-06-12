require 'package'

class Libmtp < Package
  description 'libmtp is a library to access MTP (Media Transfer Protocol) Devices.'
  homepage 'https://github.com/libmtp/libmtp/'
  version '1.1.19'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://github.com/libmtp/libmtp.git'
  git_hashtag "v#{version}"

  depends_on 'libusb'
  depends_on 'eudev'

  def self.patch
    system "sed -e 's:read IN:IN=y:' \
                -e 's:wget -O:curl -#Lo:g' \
                -i autogen.sh"
  end

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
