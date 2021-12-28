require 'package'

class Libbsd < Package
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  @_ver = '0.11.3'
  version @_ver
  license 'BSD, BSD-2, BSD-4, ISC'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libbsd.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.3_armv7l/libbsd-0.11.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.3_armv7l/libbsd-0.11.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.3_i686/libbsd-0.11.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbsd/0.11.3_x86_64/libbsd-0.11.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '391cf3f07f66a315e7da44504dc3e713c93a541b92e94e87a0383382f674113d',
     armv7l: '391cf3f07f66a315e7da44504dc3e713c93a541b92e94e87a0383382f674113d',
       i686: 'ae08dd18ad0d73e21166745bf5736f4248a42b224d3f0a94736c3172cbfb7712',
     x86_64: '55da730b6d52c086cb934546543475e298851c1060c5838bede71826631c566f'
  })

  depends_on 'libmd'

  def self.build
    FileUtils.mkdir_p 'm4'
    system 'autoupdate'
    system 'autoreconf -fiv'
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
