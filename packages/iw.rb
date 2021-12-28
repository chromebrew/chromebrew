require 'package'

class Iw < Package
  description 'iw is a new nl80211 based CLI configuration utility for wireless devices.'
  homepage 'https://wireless.wiki.kernel.org/en/users/documentation/iw/'
  @_ver = '5.16'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.16_armv7l/iw-5.16-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.16_armv7l/iw-5.16-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.16_i686/iw-5.16-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.16_x86_64/iw-5.16-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '65fc4e003fb7dd5fc962ffbc6d50dd7aec0afae7dbfb8301bdf30a9855bb63bf',
     armv7l: '65fc4e003fb7dd5fc962ffbc6d50dd7aec0afae7dbfb8301bdf30a9855bb63bf',
    i686: '7710c556d73687e599354e0932479e2f63b50317f016813d3735dbe17998a9f9',
  x86_64: '8aa9b00ac829c5f9ba048ec175311c7b453dfc432d63a681d393666a630ad932'
  })

  depends_on 'libnl3'

  def self.patch
    system "sed -i 's:/usr:#{CREW_PREFIX}:g' Makefile" # Change prefix to CREW_PREFIX
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
