require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.12.1-nodoc'
  source_url 'https://s3.amazonaws.com/json-c_releases/releases/json-c-0.12.1-nodoc.tar.gz'
  source_sha256 '5a617da9aade997938197ef0f8aabd7f97b670c216dc173977e1d56eef9e1291'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
