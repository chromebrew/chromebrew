require 'buildsystems/autotools'

class Aircrack_ng < Autotools
  description 'Key cracker for the 802.11 WEP and WPA-PSK protocols.'
  homepage 'https://www.aircrack-ng.org'
  version '1.7-b2985bf'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/aircrack-ng/aircrack-ng.git'
  git_hashtag 'b2985bf1a3ba6cd5842ceebae806ce4ba4441460'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d566a77451e65d57cbe2f402556d3308902c778186bb2da6451de7d1e27b52a',
     armv7l: '4d566a77451e65d57cbe2f402556d3308902c778186bb2da6451de7d1e27b52a',
       i686: '0e7ac13f7e3054d06206c1518519ed86ba367853134995c245ca8ff3d6eca02c',
     x86_64: '87fa96b73ec4d321b4d929b08b8ccd95e1609544c474e27bc48cbc71a7445af4'
  })

  depends_on 'libnl3'
  depends_on 'libpcap'
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'rfkill'
  depends_on 'sqlite' # R
  depends_on 'zlib' # R

  # https://github.com/aircrack-ng/aircrack-ng/issues/773
  def self.patch
    system "sed -i 's|/etc/aircrack-ng|#{CREW_PREFIX}/aircrack-ng|' scripts/airodump-ng-oui-update"
  end

  # https://github.com/aircrack-ng/aircrack-ng/issues/2623
  autotools_pre_configure_options 'CFLAGS=-Wno-error=implicit-function-declaration'
  run_tests
end
