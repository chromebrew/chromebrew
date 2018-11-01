require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.10-14-7.0.8-14'

  if ARGV[0] == 'install'
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
    puts
    puts "Enter the ImageMagick version to install:"
    puts "6 = ImageMagick 6.9.10-14"
    puts "7 = ImageMagick 7.0.8-14"
    puts "0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '6'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.10-14.tar.xz'
        source_sha256 'd123d4ad4e5bf72c51a6f528a2dbbbd4bf4249f25b36045017c9c634db968e6d'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '35aa98c93aedcf992741a8fc5043608618c3960ff4a7163e05dab46301cf0695',
           armv7l: '35aa98c93aedcf992741a8fc5043608618c3960ff4a7163e05dab46301cf0695',
             i686: '2d517abdea774d9a2425b8b13e5fc2c94a8596e2fa058ed8871aa6295d5edd40',
           x86_64: '5a8b8ff05c66cf29715166b18c4100481577e2501332741f78eda177d19240d4',
        })
        break
      when '7'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.8-14.tar.xz'
        source_sha256 '70c3d8c800cfd0282c0e0d9930b83f472f9593a882adc77532aa82c0d7ca0bb1'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '17f6dea62e438159afb39eb5f02c94669bc79034efad2e7c71c384fc20b768db',
           armv7l: '17f6dea62e438159afb39eb5f02c94669bc79034efad2e7c71c384fc20b768db',
             i686: '2b36de4345ad051651732c77b65ee9d8719e9c686e2616a0aa05f74d7f976a7e',
           x86_64: 'db12c715992606dce557b5e3b81d82384e9751d9c59f3cffc9115727688cc304',
        })
        break
      when '0'
        abort
        break
      else
        puts "Please select from one of the options or enter 0 to cancel."
      end
    end
  end

  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'lzma'
  depends_on 'libwebp'
  depends_on 'msttcorefonts'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'python27'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
