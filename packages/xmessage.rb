require 'package'

class Xmessage < Package
  description 'Xmessage displays a message or query in a window.'
  homepage 'https://www.x.org/'
  version '1.0.5'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/xmessage-1.0.5.tar.bz2'
  source_sha256 '373dfb81e7a6f06d3d22485a12fcde6e255d58c6dee1bbaeb00c7d0caa9b2029'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xmessage-1.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xmessage-1.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xmessage-1.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xmessage-1.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6df6c32406b06cc78f207c28b3a8cec0c41fe98a7566bf7d73e53553c55a4ccc',
     armv7l: '6df6c32406b06cc78f207c28b3a8cec0c41fe98a7566bf7d73e53553c55a4ccc',
       i686: '9af874eed48fcad769c3eea3382448c26958b101af58f0708eefab8454d3eeed',
     x86_64: '1ccd1102b9debf4c9a7b7ca877b2010622ac013cc551fb0d7d9b3a772355ac80',
  })

  depends_on 'xorg_lib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
