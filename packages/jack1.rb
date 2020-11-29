require 'package'

class Jack1 < Package
  description 'JACK (JACK Audio Connection Kit) refers to an API that provides a basic infrastructure for audio applications to communicate with each other and with audio hardware.'
  homepage 'https://jackaudio.org/'
  version 'b04083'
  compatibility 'all'
  source_url 'https://github.com/jackaudio/jack1/archive/b04083761496410a52126cdbcd35c557ee82f2e5.tar.gz'
  source_sha256 '376f2cd292ec285e53dbd5fe30a151d8a45dd7be5034a5b05dbb7e8a4735d7b1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jack1-b04083-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jack1-b04083-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jack1-b04083-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jack1-b04083-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a14ae812ae5d89c0ca4a3922d7706fdc3ef1c5f2898a230aebd84246a2988464',
     armv7l: 'a14ae812ae5d89c0ca4a3922d7706fdc3ef1c5f2898a230aebd84246a2988464',
       i686: '475b1a17382257853fe753b27f3a7cfd6fd0d53bbf1b3a8f6d0cb0cdf7edff32',
     x86_64: 'e212d48b752a9d3e73ba430e5c1275ca8208f9bd2452f1b1024f4198f163e623',
  })

  depends_on 'alsa_plugins'

  def self.build
    system 'git clone git@github.com:jackaudio/jack1.git'
    Dir.chdir 'jack1' do
      system "git checkout #{version}"
      system 'git submodule init'
      system 'git submodule update'
      system './autogen.sh'
      system "./configure #{CREW_OPTIONS}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'jack1' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
