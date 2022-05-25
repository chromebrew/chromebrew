require 'package'

class Libsass < Package
  description 'LibSass is a C/C++ port of the Sass engine'
  homepage 'https://sass-lang.com/libsass'
  version '3.6.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sass/libsass.git'
  git_hashtag version
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsass/3.6.5_armv7l/libsass-3.6.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsass/3.6.5_armv7l/libsass-3.6.5-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsass/3.6.5_i686/libsass-3.6.5-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsass/3.6.5_x86_64/libsass-3.6.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'da6e45c3477ba90ecf8a21b4594cd3354d4d092044f331eb10a5a1eb72950ca5',
     armv7l: 'da6e45c3477ba90ecf8a21b4594cd3354d4d092044f331eb10a5a1eb72950ca5',
    i686: '4cf9b50d8ebbb48b9e3645665bcf128c09308b6aed6fca21d2bb6d07ed9959de',
  x86_64: 'af2364ca0715f59677cdc1c2b82264ea34640e1b4ce18eb1ab2b38ffa1f366d5'
  })

  def self.build
    system 'autoreconf', '-i'
    system "#{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
