require 'package'

class Sassc < Package
  description 'C implementation of Sass CSS preprocessor.'
  version '3.6.1'
  compatibility 'all'
  source_url 'https://github.com/sass/sassc/archive/3.6.1.tar.gz'
  source_sha256 '8cee391c49a102b4464f86fc40c4ceac3a2ada52a89c4c933d8348e3e4542a60'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sassc-3.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa342b7f0f008adf721fce11d5576148478d7e8008ec37be8a031e92f416b345',
     armv7l: 'fa342b7f0f008adf721fce11d5576148478d7e8008ec37be8a031e92f416b345',
       i686: '7f3d0319266009c1b7ee8949de91914116fc31b87949ba6fd57a0df3dd95633b',
     x86_64: '156f5f33817ce351f7c890eee9a37a61dcd4abc96939ba9bfa49e31264c412da',
  })

  depends_on 'libsass'

  def self.build
    system "autoreconf -i"
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
