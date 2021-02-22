require 'package'

class Libeconf < Package
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.3.8'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf/archive/v0.3.8.tar.gz'
  source_sha256 'e0c265f85eef2aca400d17b88f74891ce40ed88d959ebc29f529d26121f7e8e3'

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' \
              #{CREW_CMAKE_OPTIONS} .."
      system "ninja"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.check
    system "ninja -C builddir check"
  end
end
