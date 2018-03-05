require 'package'

class Sharedmimeinfo < Package
  description 'The Shared MIME-info Database specification. https://freedesktop.org/wiki/Software/shared-mime-info'
  homepage 'https://people.freedesktop.org/~hadess/'
  version '1.9'
  source_url 'https://people.freedesktop.org/~hadess/shared-mime-info-1.9.tar.xz'
  source_sha256 '5c0133ec4e228e41bdf52f726d271a2d821499c2ab97afd3aa3d6cf43efcdc83'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'glib'
  depends_on 'libxml2'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" # the steps required to install the package
  end
  
end
