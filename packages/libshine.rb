require 'package'

class Libshine < Package
  description 'shine is a rapid fixed-point MP3 encoder.'
  homepage 'https://github.com/toots/shine/'
  @_ver = '3.1.1'
  version @_ver
  compatibility 'all'
  license 'GPL-2'
  source_url 'https://github.com/toots/shine.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/libshine-3.1.1-chromeos-armv7l.tpxz',
      armv7l: 'file:///usr/local/tmp/packages/libshine-3.1.1-chromeos-armv7l.tpxz',
        i686: 'file:///usr/local/tmp/packages/libshine-3.1.1-chromeos-i686.tpxz',
      x86_64: 'file:///usr/local/tmp/packages/libshine-3.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6c39c86b6846811f3315b354778ae2f7f03d47be2b73a9d6a7850ff0ab480311',
      armv7l: '6c39c86b6846811f3315b354778ae2f7f03d47be2b73a9d6a7850ff0ab480311',
        i686: 'ff588c6ed23468c7c39ae9ccf0bf8252364c58d4ae3391314620aaec868aa9b2',
      x86_64: '4aae13ed0e9d3523803146076691ed92180db3f4f27247e476d4756225a36161'
  })

  def self.build
    system 'autoreconf -fiv'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
