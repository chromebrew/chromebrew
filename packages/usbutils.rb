require 'buildsystems/meson'

class Usbutils < Meson
  description 'Tools for examining usb devices'
  homepage 'https://linux-usb.sourceforge.net/'
  version '018'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/utils/usb/usbutils/usbutils-#{version}.tar.xz"
  source_sha256 '83f68b59b58547589c00266e82671864627593ab4362d8c807f50eea923cad93'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '987283deb6b628c42d2f72d1cab5b965148df3b66f026681def026e506a88dd9',
     armv7l: '987283deb6b628c42d2f72d1cab5b965148df3b66f026681def026e506a88dd9',
       i686: 'c13e904f31ed2afa1fa917d24a347414ed6aa0341c39b8087b33004c383e33c0',
     x86_64: '5793147bdf7f45c8c7f95516bc1819a28f9a96ccc8ece2f0a29a8368fa0ecfe9'
  })

  depends_on 'libusb'

  meson_install_extras do
    downloader 'http://www.linux-usb.org/usb.ids',
               'a761bd7660839cd4d6185a89c92d466cbb349e45c2639e4ed85c63c10b6fac0c'
    FileUtils.install 'usb.ids', "#{CREW_DEST_PREFIX}/share/hwdata/usb.ids", mode: 0o644
  end

  def self.postinstall
    puts "It's recommended that you setup a cron job to update this file regularly.".lightblue
    puts 'You can install a cron package by executing `crew install cronie`'.lightblue
    puts
    puts 'Add a cron job with something like the following:'.lightblue
    puts '# Update usb.ids at 6pm daily.'.lightblue
    puts "0 18 * * * #{CREW_PREFIX}/bin/curl -LO http://www.linux-usb.org/usb.ids -o #{CREW_PREFIX}/share/hwdata/usb.ids >/dev/null 2>&1".lightblue
  end
end
