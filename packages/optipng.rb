require 'package'

class Optipng < Package
  description 'OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information.'
  homepage 'http://optipng.sourceforge.net/'
  version '0.7.7'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/optipng/OptiPNG/optipng-0.7.7/optipng-0.7.7.tar.gz'
  source_sha256 '4f32f233cef870b3f95d3ad6428bfe4224ef34908f1b42b0badf858216654452'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/optipng-0.7.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/optipng-0.7.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/optipng-0.7.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/optipng-0.7.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1601aa1f127fdb2eacad1c0faa347c405722e208387fea068a9566d11373c92f',
     armv7l: '1601aa1f127fdb2eacad1c0faa347c405722e208387fea068a9566d11373c92f',
       i686: '6ce2f78ccb3a4d33cb15843735ee93ef42f7862f448cbf2fdb2515e5e355b364',
     x86_64: 'cc4c62f535d32680b40ec79f8334b1d046032ff773596cc87f2c127128b032d3',
  })

  depends_on 'libpng'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --with-system-libpng" # Bundled libpng doesn't work on armv7l
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
