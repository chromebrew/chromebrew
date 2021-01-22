require 'package'
  
class At_spi2_atk < Package
  description 'D-Bus AT-SPI'
  homepage 'http://www.freedesktop.org/'
  version '2.38.0'
  compatibility 'all'
  source_url 'https://github.com/GNOME/at-spi2-atk/archive/AT_SPI2_ATK_2_38_0.tar.gz'
  source_sha256 '95f10c80834d3811938153199da671967ee3c8f378883ed3f6ddeee1d316d3e4'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.38.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.38.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.38.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/at_spi2_atk-2.38.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '097744ccba6da2013771b9da22a887e64cd6fd0df0b39bc1576e9131e1ff30a9',
      armv7l: '097744ccba6da2013771b9da22a887e64cd6fd0df0b39bc1576e9131e1ff30a9',
        i686: '12aba0b16a694f3e79e7fa562bfd7510c27d8d4864a5b57f9caed48e7801a890',
      x86_64: 'ce793ff57e4c0ba75b76e8f12934741f6cb26b4d02cc9080e647c28170b1f627',
  })

  depends_on 'automake' => :build
  depends_on 'at_spi2_core'
  depends_on 'atk'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
