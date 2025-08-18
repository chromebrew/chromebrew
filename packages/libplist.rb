require 'package'

class Libplist < Package
  description 'A library to handle Apple Property List format'
  homepage 'https://libimobiledevice.org/'
  version '2.7.0'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://github.com/libimobiledevice/libplist/archive/#{version}.tar.gz"
  source_sha256 '66fa17a29270cb25ceaf189430ea38037c066652c2989b58d7ef6120b1a208d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5494b780369670c29f13fcdbb2c9929109da7e0849cad829f7e6bfb6d1f51690',
     armv7l: '5494b780369670c29f13fcdbb2c9929109da7e0849cad829f7e6bfb6d1f51690',
       i686: '5b4c2083b045022f9d55966478f1942c1c7f212933bca6000ca8820bb588c426',
     x86_64: 'def23cf8dea8fabebc2b04f0489ec4469587d31ba5a9d19c429bb491a437d049'
  })

  depends_on 'glib'

  def self.build
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      CC=gcc \
      ./autogen.sh #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
