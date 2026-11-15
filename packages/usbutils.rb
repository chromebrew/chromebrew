require 'buildsystems/meson'

class Usbutils < Meson
  description 'Tools for examining usb devices'
  homepage 'https://linux-usb.sourceforge.net/'
  version '020'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/utils/usb/usbutils/usbutils-#{version}.tar.xz"
  source_sha256 '20287d68fcd9ebb50a05ba0645a4af7583bd8dfc7307215ba121e4bc6d057aa1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd971440964123021c75cd24f42004f6edea5f3d42eb94dfdcc373b4f041af4b7',
     armv7l: 'd971440964123021c75cd24f42004f6edea5f3d42eb94dfdcc373b4f041af4b7',
       i686: '0066e8fc18895e2c1aaa997b44244ad1d88245e7922ae3987ab819828af64c0b',
     x86_64: '455b48b745992cd780d2f1e0a217f280e603562ce79979fcc41f083d6ed4e9bc'
  })

  depends_on 'eudev' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libusb' => :executable

  meson_install_extras do
    downloader 'http://www.linux-usb.org/usb.ids',
               'a761bd7660839cd4d6185a89c92d466cbb349e45c2639e4ed85c63c10b6fac0c'
    FileUtils.install 'usb.ids', "#{CREW_DEST_PREFIX}/share/hwdata/usb.ids", mode: 0o644
  end

  def self.postbuild
    # Fix /usr/local/bin/usb-devices: 200: /usr/local/bin/usb-devices: Syntax error: Missing '))'
    system "sed -i '77,78d' #{CREW_DEST_PREFIX}/bin/usb-devices"
    system "sed -i '77imaxps\=\$\(\$\(printf \"%4i*%s\\n\" \$\(maxps_hex & 0x7ff\) \$\(1 \+ \$\(maxps_hex \>\> 11\) & 0x3\)\)\)' #{CREW_DEST_PREFIX}/bin/usb-devices"
  end

  def self.postinstall
    ExitMessage.add <<~EOM
      It's recommended that you setup a cron job to update this file regularly.
      You can install a cron package by executing `crew install cronie`

      Add a cron job with something like the following:
      # Update usb.ids at 6pm daily.
      0 18 * * * #{CREW_PREFIX}/bin/curl -LO http://www.linux-usb.org/usb.ids -o #{CREW_PREFIX}/share/hwdata/usb.ids >/dev/null 2>&1
    EOM
  end
end
