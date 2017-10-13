require 'package'

class Smem < Package
  description 'A Linux memory reporting tool that uses proportional set size.'
  homepage 'https://www.selenic.com/smem/'
  version '1.4'
  source_url 'https://www.selenic.com/smem/download/smem-1.4.tar.gz' 
  source_sha256 '2ea9f878f4cf3c276774c3f7e2a41977a1f2d64f98d2dcb6a15f1f3d84df61ec'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential' => :build
  depends_on 'python27'

  def self.build
    system 'make smemcap'
  end

  def self.install
    system "install -Dm755 smem #{CREW_DEST_PREFIX}/bin/smem"
    system "install -Dm755 smemcap #{CREW_DEST_PREFIX}/bin/smemcap"
    system "install -Dm643 smem.8 #{CREW_DEST_PREFIX}/man/man8/smem.8"
  end
end
