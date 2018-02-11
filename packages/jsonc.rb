require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.13-nodoc'
  source_url 'https://s3.amazonaws.com/json-c_releases/releases/json-c-0.13-nodoc.tar.gz'
  source_sha256 '8572760646e9d23ee68f967ca62fa134a97b931665fd9af562192b7788c95a06'

  depends_on "autoconf" => :build

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
