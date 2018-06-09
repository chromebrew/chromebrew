require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-50-7.0.7-38'

  if ARGV[0] == 'install'
    imver = `stream -version 2> /dev/null | head -1 | cut -d' ' -f3`.chomp
    abort "ImageMagick version #{imver} already installed.".lightgreen unless "#{imver}" == ""
    puts
    puts "Enter the ImageMagick version to install:"
    puts "6 = ImageMagick 6.9.9-50"
    puts "7 = ImageMagick 7.0.7-38"
    puts "0 = Cancel"

    while version = STDIN.gets.chomp
      case version
      when '6'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-50.tar.xz'
        source_sha256 'b6a8b6afea4cd0ea87e752a83bc66b13200e219e0a476156a83a259be3760560'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-50-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-50-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-50-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-50-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '90af69292dc58d68a81b4047be0ddf56c98e6548f5bd15f096228690039d6135',
           armv7l: '90af69292dc58d68a81b4047be0ddf56c98e6548f5bd15f096228690039d6135',
             i686: '4721027f02c5cb590ac73dcc97ce505e0504f3c9810fb922f8482f5c114631b1',
           x86_64: '6e176b5027fdb3170561b50aefdf2738eb656f7373973c10c56922b93dcbb220',
        })
        break
      when '7'
        source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-38.tar.xz'
        source_sha256 'db6a88477dc7290a450570d215ae68caf83e0d80c868addefb608109978db17b'
        binary_url ({
          aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-38-chromeos-armv7l.tar.xz',
           armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-38-chromeos-armv7l.tar.xz',
             i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-38-chromeos-i686.tar.xz',
           x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.7-38-chromeos-x86_64.tar.xz',
        })
        binary_sha256 ({
          aarch64: '8af6733552d6d8f2b08f4f4f8a069de5b8e16916fb0e0508c206a4ef2769f5c2',
           armv7l: '8af6733552d6d8f2b08f4f4f8a069de5b8e16916fb0e0508c206a4ef2769f5c2',
             i686: '965af8c91a324d4e74383cf2cd2b976bb318f6e869da313c444aff23eb6a9d0b',
           x86_64: 'a763794967fe8d825809155db55a61e3b4b4ed09521c20f861a622870304e9bf',
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
  depends_on 'lcms'
  depends_on 'lzma'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'msttcorefonts'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'perl'
  depends_on 'python27'
  depends_on 'zlibpkg'

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
