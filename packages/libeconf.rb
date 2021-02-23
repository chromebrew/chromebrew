require 'package'

class Libeconf < Package
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.3.8'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf/archive/v0.3.8.tar.gz'
  source_sha256 'e0c265f85eef2aca400d17b88f74891ce40ed88d959ebc29f529d26121f7e8e3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libeconf-0.3.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libeconf-0.3.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libeconf-0.3.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libeconf-0.3.8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '48ea1c16670d3f19656f6abbec7c3b218a67946512dc53b3707bacba4b36f6aa',
     armv7l: '48ea1c16670d3f19656f6abbec7c3b218a67946512dc53b3707bacba4b36f6aa',
       i686: 'c9f3090f534cbc02e7c44f02289d5c2140567cb071b309efda03ad22ebcdb7a8',
     x86_64: '8172738483bdac025f09f95dcb3508d75c39c392900e6d7b73474d3513d15ca1'
  })

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' \
        cmake -G 'Ninja' \
        #{CREW_CMAKE_OPTIONS} .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system 'ninja -C builddir check'
  end
end
