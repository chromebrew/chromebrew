require 'buildsystems/meson'

class Usbutils < Meson
  description 'Tools for examining usb devices'
  homepage 'https://linux-usb.sourceforge.net/'
  version '019'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/utils/usb/usbutils/usbutils-#{version}.tar.xz"
  source_sha256 '659f40c440e31ba865c52c818a33d3ba6a97349e3353f8b1985179cb2aa71ec5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1fe75c769e0ca099a22c80412ddb1502b342e330ac17111a5de441f507027a86',
     armv7l: '1fe75c769e0ca099a22c80412ddb1502b342e330ac17111a5de441f507027a86',
       i686: 'bc1dcf49696c72b0166130339f72193bae79a0e9d280c8d3a4a6bfed519c4f6d',
     x86_64: 'fe3326d1d91b055cb8985d04a424d6b31db45b7ad16927097aee4263f36064b7'
  })

  depends_on 'eudev' => :library
  depends_on 'glibc' => :library
  depends_on 'libusb' => :library

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
