require 'package'

class Libcap_ng < Package
  description 'The libcap-ng library is intended to make programming with posix capabilities much easier than the traditional libcap library.'
  homepage 'https://people.redhat.com/sgrubb/libcap-ng'
  version '0.7.8-0'
  source_url 'https://people.redhat.com/sgrubb/libcap-ng/libcap-ng-0.7.8.tar.gz'
  source_sha256 'c21af997445cd4107a55d386f955c5ea6f6e96ead693e9151277c0ab5f97d05f'

  binary_url ({

  })
  binary_sha256 ({

  })

  depends_on 'python3'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
