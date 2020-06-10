require 'package'

class Bitpocket < Package
  description '"DIY Dropbox" or "2-way directory (r)sync with proper deletion"'
  homepage 'https://github.com/sickill/bitpocket'
  version '0.2'
  compatibility 'all'
  source_url 'https://github.com/sickill/bitpocket/archive/v0.2.tar.gz'
  source_sha256 'f3952374a1139465700f9122d7a929227be5cdeb681679cbe00bb93658adbd1f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bitpocket-0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bitpocket-0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bitpocket-0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bitpocket-0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b94a65b172e2c93a8a35bd6c6642d61023b0c91ab9f2ba9a8db7f7dca9c150e',
     armv7l: '7b94a65b172e2c93a8a35bd6c6642d61023b0c91ab9f2ba9a8db7f7dca9c150e',
       i686: '42fcb4adb063c62d0a5907739b420e9a75457d51df44b64aa6b1600d2e81b3bf',
     x86_64: '65b995eb9ea17bbce09c47d786cb1c38afac27952f2795fbcc4208b971e9de4a',
  })

  def self.install
    system "install -Dm755 bin/bitpocket #{CREW_DEST_PREFIX}/bin/bitpocket"
  end
end
