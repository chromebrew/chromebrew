require 'package'

class Libffi < Package
  description 'The libffi library provides a portable, high level programming interface to various calling conventions.'
  homepage 'https://github.com/libffi/libffi/'
  @_ver = '3.4.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libffi/libffi.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2_armv7l/libffi-3.4.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2_armv7l/libffi-3.4.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2_i686/libffi-3.4.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libffi/3.4.2_x86_64/libffi-3.4.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7a1ec1ebdc7b4aab6b7b775fb99d3553bb15abfb068c773d3397b1a53d7a4ce5',
     armv7l: '7a1ec1ebdc7b4aab6b7b775fb99d3553bb15abfb068c773d3397b1a53d7a4ce5',
       i686: '691e3ae233f84c099811fc457699e3f52a89e617d58406bc3e159b3d8de51bd4',
     x86_64: '3693f9dd48869782a45878b97bbc8a7e24ec852393c64298b5fb9619f4507943'
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
    # system "make check"         # DejaGNU required
  end
end
