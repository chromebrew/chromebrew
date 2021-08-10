require 'package'

class Oneko < Package
  description 'A cat chases around your mouse cursor.'
  homepage 'http://www.daidouji.com/oneko/'
  @_ver = '1.2.sakura.6-15'
  version @_ver
  license 'public-domain'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/o/oneko/oneko_1.2.sakura.6.orig.tar.gz'
  source_sha256 'd89cee8b81cdb40ef23b3457c9a7fe1b0ff130081b21a41ec6c41cda01391d25'

  depends_on 'libx11'
  depends_on 'libxext'
  #depends_on 'sommelier'
  depends_on 'imake' => :build
  depends_on 'xorg_cf_files' => :build
  depends_on 'gccmakedep' => :build

  extra_url "https://httpredir.debian.org/debian/pool/main/o/oneko/oneko_#{@_ver}.debian.tar.xz" => '8f12f3e167f100e0fcef5185f6f1faf47cb627d96c7011e580348f5f317e76b4'
  extra_url 'https://bouncer.gentoo.org/fetch/root/all/distfiles/oneko-1.2-cat.png' => '994dec71c4021f4e228b8c69fcefde5b11244445ff8ff6d43b3790beecef5800'
  extra_url 'https://bouncer.gentoo.org/fetch/root/all/distfiles/oneko-1.2-dog.png' => '5ca2d41b5538618196cfe9e40dd75856fde77fe35cba99ed9b2eacf1fb0e5502'

  def self.patch
    system "tar xf oneko_#{@_ver}.debian.tar.xz"
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
