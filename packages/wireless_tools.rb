require 'package'

class Wireless_tools < Package
  description 'Wireless Tools for Linux'
  homepage 'https://github.com/HewlettPackard/wireless-tools'
  version '2.9'
  source_url 'https://github.com/HewlettPackard/wireless-tools/archive/v29.tar.gz'
  source_sha256 '69c5face9ac9d3273042436408a9a057d3416a814253dedeaaef210fcbc42d40'

  binary_url ({
  })
  binary_sha256 ({
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
