require 'package'

class Bdwgc < Package
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collecto'
  homepage 'https://github.com/ivmai/bdwgc'
  version '7.6.4'
  source_url 'https://github.com/ivmai/bdwgc/archive/v7.6.4.tar.gz'
  source_sha256 '1f85bf6d4aaa3fb12fe0178b13d9685e2d0c3a4d115dea5f831c54deafa3f6db'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bdwgc-7.6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7df9bac9f3235d3cd619549048a7f9ade8109026c8410d54ed0b0b3f33fefdab',
     armv7l: '7df9bac9f3235d3cd619549048a7f9ade8109026c8410d54ed0b0b3f33fefdab',
       i686: 'fffebf06f10c8e14c75201d01932e7c6a0520baf7ae7798a62a591e7710f21dc',
     x86_64: 'd3f0b3644dc8b9e810dd7f6efeafa159164884697a45bc60f472c84a624e92b1',
  })

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pkgconfig' => :build

  depends_on 'libatomic_ops'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
