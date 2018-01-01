require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.13-20171207'
  source_url 'https://github.com/json-c/json-c/archive/json-c-0.13-20171207.tar.gz'
  source_sha256 '26e642456caab38aa9459279b9712ffec52f751e9f46641d28461c244bd6bae6'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
