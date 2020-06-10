require 'package'

class Mypaint_brushes < Package
  description 'Brushes used by MyPaint and other software using libmypaint.'
  homepage 'https://github.com/Jehan/mypaint-brushes'
  version '1.3.0'
  compatibility 'all'
  source_url 'https://github.com/Jehan/mypaint-brushes/archive/v1.3.0/mypaint-brushes-v1.3.0.tar.gz'
  source_sha256 '704bb6420e65085acfd7a61d6050e96b0395c5eab078433f11406c355f16b214'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint_brushes-1.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint_brushes-1.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint_brushes-1.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mypaint_brushes-1.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '87eed1b1688597faac6b4910e1489d6fc4967af705b6594eaf9fdb5568a44dd1',
     armv7l: '87eed1b1688597faac6b4910e1489d6fc4967af705b6594eaf9fdb5568a44dd1',
       i686: '640c1fb3ad85e6ff83f84a5caa514e08bf65ec61403e53a72908c6a818335bde',
     x86_64: '28166ca3a372eec0ef0d97193fb65225e9edbb6d2288821fcfa291d1ddb8b26a',
  })

  depends_on 'libmypaint'

  def self.patch
    system "wget http://www.linuxfromscratch.org/patches/blfs/svn/mypaint-brushes-1.3.0-automake_1.16-1.patch"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('mypaint-brushes-1.3.0-automake_1.16-1.patch') ) == '789f9233a31227c1acc2f81a5348a2d5bc7f656ae69044c0b33d0032d1f93ae2'
    system "patch -Np1 -i mypaint-brushes-1.3.0-automake_1.16-1.patch"
  end

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
