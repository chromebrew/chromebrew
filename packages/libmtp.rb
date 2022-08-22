require 'package'

class Libmtp < Package
  description 'libmtp is a library to access MTP (Media Transfer Protocol) Devices.'
  homepage 'https://github.com/libmtp/libmtp/'
  @_ver = '1.1.19'
  version @_ver
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://github.com/libmtp/libmtp.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/libmtp-1.1.19-chromeos-armv7l.tpxz',
      armv7l: 'file:///usr/local/tmp/packages/libmtp-1.1.19-chromeos-armv7l.tpxz',
        i686: 'file:///usr/local/tmp/packages/libmtp-1.1.19-chromeos-i686.tpxz',
      x86_64: 'file:///usr/local/tmp/packages/libmtp-1.1.19-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5a73ce6f6fa953a42f6340f1a629700c99486b1a85cb13bb70a98b203bff618a',
      armv7l: '5a73ce6f6fa953a42f6340f1a629700c99486b1a85cb13bb70a98b203bff618a',
        i686: '0ae7fe1ddd6df6a6598f82d63531296fb925c97eddce6e88512321229ca7432a',
      x86_64: '186ffe6bf627eb846e40ce77eff0df4f49ca67e7238b8dec03e74d48e560fb71'
  })

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
