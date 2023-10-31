require 'package'

class Libzip < Package
  description 'libzip is a C library for reading, creating, and modifying zip archives.'
  homepage 'https://libzip.org/'
  version '1.7.3-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://libzip.org/download/libzip-1.7.3.tar.xz'
  source_sha256 'a60473ffdb7b4260c08bfa19c2ccea0438edac11193c3afbbb1f17fbcf6c6132'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libzip/1.7.3-1_armv7l/libzip-1.7.3-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libzip/1.7.3-1_armv7l/libzip-1.7.3-1-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libzip/1.7.3-1_i686/libzip-1.7.3-1-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libzip/1.7.3-1_x86_64/libzip-1.7.3-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '816fc0aa5940b01c94631f6d4215b2e8990738a51022fe7e7094fa471afd50ff',
      armv7l: '816fc0aa5940b01c94631f6d4215b2e8990738a51022fe7e7094fa471afd50ff',
        i686: '75cd419eba9935ab1d6580fce78788b1564099f0443ad611de3e236c3b02981a',
      x86_64: 'dd16146327e8c8a91d0cdd5b1f2c776657bda33697c2a9e216e6804c115ac06c'
  })

  depends_on 'bzip2'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env #{CREW_ENV_OPTIONS} \
        cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
      system 'ninja'
    end
  end

  def self.check
    system 'ninja -C builddir test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
