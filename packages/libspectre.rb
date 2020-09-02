require 'package'

class Libspectre < Package
  description 'Small library for rendering Postscript documents'
  homepage 'https://www.freedesktop.org/wiki/Software/libspectre/'
  version '0.2.9'
  compatibility 'all'
  source_url 'https://libspectre.freedesktop.org/releases/libspectre-0.2.9.tar.gz'
  source_sha256 '49ae9c52b5af81b405455c19fe24089d701761da2c45d22164a99576ceedfbed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libspectre-0.2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libspectre-0.2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libspectre-0.2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libspectre-0.2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4b475b4e20a95c3ae4a2b9c515b63b865395d3885291f8339adc25315a47c09e',
     armv7l: '4b475b4e20a95c3ae4a2b9c515b63b865395d3885291f8339adc25315a47c09e',
       i686: '1d329f12e3b38090cb438e550967caf3d974ca7544235746b436b8ad5b7bb443',
     x86_64: '27903948a5042bb286bd1654d979376b2318980629bc44b94fb89b77a36dfec3',
  })

  depends_on 'ghostscript' # = libgs

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-static"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
