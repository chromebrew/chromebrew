require 'package'

class Alsa_utils < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.3'
  compatibility 'all'
  source_url 'https://github.com/alsa-project/alsa-utils/archive/v1.2.3.tar.gz'
  source_sha256 '68dff0dc66f0f35f91a4673896ab59bf1e59c53b3860e112fa0f310ae88c9f74'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'alsa_lib'

  def self.build
    system "./gitcompile --prefix=#{CREW_PREFIX}"
  end

  def self.check
    # This takes several hours to run!
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
