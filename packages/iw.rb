require 'package'

class Iw < Package
  description 'iw is a new nl80211 based CLI configuration utility for wireless devices.'
  homepage 'https://wireless.wiki.kernel.org/en/users/documentation/iw/'
  version '5.19'
  license 'ISC'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.19_armv7l/iw-5.19-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.19_armv7l/iw-5.19-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.19_i686/iw-5.19-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iw/5.19_x86_64/iw-5.19-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '12c0478d9fcfd42d93960600ebbd31bbc332246956728b7e9cba807e9926116a',
     armv7l: '12c0478d9fcfd42d93960600ebbd31bbc332246956728b7e9cba807e9926116a',
       i686: 'f6265a053c1ae13fd0e985ebd29684a0b74d7d0165856be5c7abc68d8105b327',
     x86_64: 'c6cfb6572a7dfa450e1d9c6bc163321b04b39abca907a82e9ad7ea4eb90ac323'
  })

  depends_on 'libnl3'
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

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
