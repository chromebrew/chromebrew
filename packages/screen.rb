require 'package'

class Screen < Package
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.8.0'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/screen/screen-4.8.0.tar.gz'
  source_sha256 '6e11b13d8489925fde25dfb0935bf6ed71f9eb47eff233a181e078fde5655aa1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/screen/4.8.0_armv7l/screen-4.8.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/screen/4.8.0_armv7l/screen-4.8.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/screen/4.8.0_i686/screen-4.8.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/screen/4.8.0_x86_64/screen-4.8.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9326008594f4e219f65995c8ee60e2aa5053b507d6b03c0561f2090ecae35f4e',
     armv7l: '9326008594f4e219f65995c8ee60e2aa5053b507d6b03c0561f2090ecae35f4e',
       i686: 'c7cf733507523e8e57c5b290c9b131a08d0c9a824b5ccc68a578e448afa152ca',
     x86_64: '4ca4a6c4da3801b368b2cdc924310e304fb378ece773e15e7ca714c7ad0c94b3'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS} \
      --enable-colors256"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
