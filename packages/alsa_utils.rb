require 'package'

class Alsa_utils < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.4'
  compatibility 'all'
  source_url "https://github.com/alsa-project/alsa-utils/archive/v#{version}.tar.gz"
  source_sha256 '4fdd1745d6ad339be596ba66c12c0ee513aab19050bd48439f91edafbd8688b0'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.4-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.4-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.4-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '40412aaf27fd4e38efe2613a8ee92d6a6f91dcf33b58e3c39a4bd65f1c12cf34',
      armv7l: '40412aaf27fd4e38efe2613a8ee92d6a6f91dcf33b58e3c39a4bd65f1c12cf34',
        i686: 'c1e9ac9a17508f1d5f314d556ceadaf29449de67cd139fc64bba42f9666a921f',
      x86_64: '081f05bf5548ea9e01743e79c9d379d128b2db43cf3007c8c945bb8c1b346d0c',
  })


  depends_on 'alsa_lib'
  depends_on 'cras'

  def self.patch
    system "sed -i 's/export CFLAGS=/export CFLAGS+=/g' gitcompile"
  end
  
  def self.build
    system "CFLAGS='-fuse-ld=lld ' ./gitcompile #{CREW_OPTIONS}"
  end

  def self.check
    # This takes several hours to run!
    #system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
