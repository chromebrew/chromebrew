require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c/wiki'
  version '0.12.1-nodoc'
  source_url 'https://s3.amazonaws.com/json-c_releases/releases/json-c-0.12.1-nodoc.tar.gz'
  source_sha256 '5a617da9aade997938197ef0f8aabd7f97b670c216dc173977e1d56eef9e1291'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/jsonc-0.12.1-nodoc-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/jsonc-0.12.1-nodoc-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/jsonc-0.12.1-nodoc-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/jsonc-0.12.1-nodoc-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '48fa744832dce095fe3d1a5d362b896b2d5a754207db4c9744acb58cf75a5dc1',
     armv7l: '48fa744832dce095fe3d1a5d362b896b2d5a754207db4c9744acb58cf75a5dc1',
       i686: 'c6f53630a47e62238fdc973e6b9ea7c0a0b0346cb320a9ea19d5e72b30e7c6d0',
     x86_64: 'fdd9d9e5d263fef32972f841cc92e77be61a6df5d175e8ae4033c0df62737ba9',
  })

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
