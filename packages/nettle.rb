require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.4'
  source_url 'https://ftp.gnu.org/gnu/nettle/nettle-3.4.tar.gz'
  source_sha256 'ae7a42df026550b85daca8389b6a60ba6313b0567f374392e54918588a411e94'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dc024f494ed4d40ce5446e16f9283fa982d942707f277157ad5843df44a663f6',
     armv7l: 'dc024f494ed4d40ce5446e16f9283fa982d942707f277157ad5843df44a663f6',
       i686: '63a02941161f7192b4117a903bad623d07be8972cdcc67b0937ff412c225d9e7',
     x86_64: '80b08e171c27c98468dbb55f6f57fb742ced7708101e05cb04e40a9224ec3624',
  })

  depends_on 'm4'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
