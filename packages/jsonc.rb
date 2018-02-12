require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.13-nodoc'
  source_url 'https://s3.amazonaws.com/json-c_releases/releases/json-c-0.13-nodoc.tar.gz'
  source_sha256 '8572760646e9d23ee68f967ca62fa134a97b931665fd9af562192b7788c95a06'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13-nodoc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13-nodoc-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13-nodoc-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jsonc-0.13-nodoc-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7a7202d506c9ed3580b02f37e7aae42ecb665e240fa45d09d16cb9c4de501745',
     armv7l: '7a7202d506c9ed3580b02f37e7aae42ecb665e240fa45d09d16cb9c4de501745',
       i686: 'c9305143aec228f737b3fc952ccd22ae0e139174b7bd46e8f25ef06b2bdf2131',
     x86_64: 'ecfa4db7850b31558d70ac0d92f372c4fd1082fcd04130a51b4520f591bcb5fb',
  })

  depends_on "autoconf" => :build

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
