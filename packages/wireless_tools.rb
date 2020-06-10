require 'package'

class Wireless_tools < Package
  description 'Wireless Tools for Linux'
  homepage 'https://github.com/HewlettPackard/wireless-tools'
  version '2.9'
  compatibility 'all'
  source_url 'https://github.com/HewlettPackard/wireless-tools/archive/v29.tar.gz'
  source_sha256 '69c5face9ac9d3273042436408a9a057d3416a814253dedeaaef210fcbc42d40'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wireless_tools-2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wireless_tools-2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wireless_tools-2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wireless_tools-2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'df298e3972dea2f49eec0009fcd651196da3c63430fc1f4e7e0773d6f1a2d4bf',
     armv7l: 'df298e3972dea2f49eec0009fcd651196da3c63430fc1f4e7e0773d6f1a2d4bf',
       i686: 'ac6e1d412978402488d60a192aa41c8ca2ed6f4bacf6d231c8e398f9c9ec6d3f',
     x86_64: '23de1b7f6dd37177fbd6a3c5ac8917c7c61db74ce774606cbb3f5efe4da03e88',
  })

  def self.build
    Dir.chdir ("wireless_tools") do
      system 'make'
    end
  end

  def self.install
    Dir.chdir ("wireless_tools") do
      system "make", "INSTALL_MAN=#{CREW_DEST_PREFIX}/share/man", "INSTALL_LIB=#{CREW_DEST_LIB_PREFIX}", "PREFIX=#{CREW_DEST_PREFIX}", "install"
    end
  end
end
