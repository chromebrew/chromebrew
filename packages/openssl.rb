require 'package'

class Openssl < Package
  description 'OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.'
  homepage 'https://www.openssl.org/'
  version '1.1.1a'
  source_url 'https://www.openssl.org/source/openssl-1.1.1a.tar.gz'
  source_sha256 'fc20130f8b7cbd2fb918b2f14e2f429e109c31ddd0fb38fc5d71d9ffed3f9f41'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'bc' => :build

  def self.build
    options = 'enable-ssl3-method disable-deprecated enable-heartbeats zlib-dynamic enable-ssl3 enable-rc5 enable-md2 enable-egd threads shared'

    case ARCH
    when 'armv7l', 'aarch64'
      options += ' linux-armv4'
    when 'i686'
      options += ' linux-x86'
    when 'x86_64'
      options += ' linux-x86_64'
      options += ' enable-ec_nistp_64_gcc_128'
    else
      options += ' linux-elf'
    end
    system "./Configure --openssldir=#{CREW_PREFIX}/etc/ssl --prefix=#{CREW_PREFIX} --libdir=#{ARCH_LIB} #{options}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'test'
  end
end
