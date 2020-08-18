require 'package'

class Alsa_utils < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.3'
  compatibility 'all'
  source_url 'https://github.com/alsa-project/alsa-utils/archive/v1.2.3.tar.gz'
  source_sha256 '68dff0dc66f0f35f91a4673896ab59bf1e59c53b3860e112fa0f310ae88c9f74'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4e216492f7467819d7a07a91cdcee306f4b378c63a415ef21a7ec74ce67da2af',
     armv7l: '4e216492f7467819d7a07a91cdcee306f4b378c63a415ef21a7ec74ce67da2af',
       i686: '90c47bc05cecdb73130bbccd40b4df94cb07e9f4178a6c3aaef1bb402049eab4',
     x86_64: 'b3b132426517895aa18589c78316e102212b3b94b5e0650f37cae13bca464275',
  })

  depends_on 'alsa_lib'

  def self.build
    system "./gitcompile --prefix=#{CREW_PREFIX}"
  end

  def self.check
    # This takes several hours to run!
    #system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
