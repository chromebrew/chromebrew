require 'package'

class Libxcomposite < Package
  description 'X.org X Composite Library'
  homepage 'http://www.x.org'
  version '0.4.6'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxcomposite.git'
  git_hashtag "libXcomposite-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcomposite/0.4.6_armv7l/libxcomposite-0.4.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcomposite/0.4.6_armv7l/libxcomposite-0.4.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcomposite/0.4.6_i686/libxcomposite-0.4.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxcomposite/0.4.6_x86_64/libxcomposite-0.4.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '51c1b43de8125c96d80e74e147e45ade10312f3ccefbb9a4f81f76a1db4e7877',
     armv7l: '51c1b43de8125c96d80e74e147e45ade10312f3ccefbb9a4f81f76a1db4e7877',
       i686: 'b4aa01d2bcba520018c92f047bad4de41be98e48f1eba549b1055979b2744495',
     x86_64: 'c4b408ff17ed182879a50321103b7b06d35a19029c9a5c86ccd044597158f900'
  })

  depends_on 'libxfixes' => :build
  depends_on 'libxext' => :build
  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
