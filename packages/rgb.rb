require 'package'

class Rgb < Package
  description 'X color name database'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.6'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/rgb-1.0.6.tar.bz2'
  source_sha256 'bbca7c6aa59939b9f6a0fb9fff15dfd62176420ffd4ae30c8d92a6a125fbe6b0'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6_armv7l/rgb-1.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6_armv7l/rgb-1.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6_i686/rgb-1.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6_x86_64/rgb-1.0.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '383f3eb09ad356d72aec226b445f8b69f33f64ddc51279e84e046fcec83a293a',
     armv7l: '383f3eb09ad356d72aec226b445f8b69f33f64ddc51279e84e046fcec83a293a',
       i686: 'f0cf3ee49517e01bd7d97bf017b48253f19bb6dd304ab4b59f6612db57756fe1',
     x86_64: '021c3ce30ac996c8bfbcda435612a1d5d0a449f96ff1ae88f0b5c7903b7ca141',
  })

  def self.build
    system './autogen.sh'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
