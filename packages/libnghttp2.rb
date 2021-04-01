require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version '1.43.0'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/nghttp2/nghttp2/releases/download/v#{version}/nghttp2-#{version}.tar.bz2"
  source_sha256 '556f24653397c71ebb8270b3c5e5507f0893e6eac2c6eeda6be2ecf6e1f50f62'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.43.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.43.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.43.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.43.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '3a760af4f8f0e4bec998be98b6f942d3baa2bc270a40780922d3bb69b36052af',
     armv7l: '3a760af4f8f0e4bec998be98b6f942d3baa2bc270a40780922d3bb69b36052af',
       i686: 'ae37feacc654b4f97090ac642003ec9bd1edc2447f19679ba2d03b1c6ec7f6cb',
     x86_64: 'af383eeeaaa588726efbd85d883d2eee1f3799a9687d2c16904d229c5662d3db'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
