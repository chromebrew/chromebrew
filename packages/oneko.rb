require 'package'

class Oneko < Package
  description 'A cat chases around your mouse cursor.'
  homepage 'http://www.daidouji.com/oneko/'
  version '1.2.sakura.6'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/o/oneko/oneko_1.2.sakura.6.orig.tar.gz'
  source_sha256 'd89cee8b81cdb40ef23b3457c9a7fe1b0ff130081b21a41ec6c41cda01391d25'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/oneko-1.2.sakura.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/oneko-1.2.sakura.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/oneko-1.2.sakura.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/oneko-1.2.sakura.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '18128ddab7d13999c43c4fa2ce24fdd15a9bcd4541a815ad8c19f9154d006db8',
     armv7l: '18128ddab7d13999c43c4fa2ce24fdd15a9bcd4541a815ad8c19f9154d006db8',
       i686: '68469cb17415e9088f966a3b6551b52dcfcd15f3cec905e91fa4c7eca16dc3a0',
     x86_64: 'abcfe89e40fb13c5df22abcbae616892d9f9917ef931520a80dbbd067bb0775d',
  })
  
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'sommelier'
  depends_on 'imake' => :build
  depends_on 'xorg_cf_files' => :build
  depends_on 'gccmakedep' => :build

  def self.patch
    # Download extra sources
    system "curl -#LO https://httpredir.debian.org/debian/pool/main/o/oneko/oneko_1.2.sakura.6-15.debian.tar.xz"
    system "curl -#LO https://bouncer.gentoo.org/fetch/root/all/distfiles/oneko-1.2-cat.png"
    system "curl -#LO https://bouncer.gentoo.org/fetch/root/all/distfiles/oneko-1.2-dog.png"
    # Verify the sources
    @sha256sums = <<~EOF
      8f12f3e167f100e0fcef5185f6f1faf47cb627d96c7011e580348f5f317e76b4  oneko_1.2.sakura.6-15.debian.tar.xz
      994dec71c4021f4e228b8c69fcefde5b11244445ff8ff6d43b3790beecef5800  oneko-1.2-cat.png
      5ca2d41b5538618196cfe9e40dd75856fde77fe35cba99ed9b2eacf1fb0e5502  oneko-1.2-dog.png
    EOF
    IO.write("sha256sums", @sha256sums)
    system "sha256sum -c sha256sums"
    # Unpack the patches
    system "tar xf oneko_1.2.sakura.6-15.debian.tar.xz"
    # Patch the patches
    system "for patch in $(cat debian/patches/series); do patch -p 1 -i debian/patches/${patch}; done"
  end
  
  def self.prebuild
    # Turn the Imakefile into a Makefile
    system "xmkmf -a"
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
