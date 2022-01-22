# Adapted from Arch Linux lilv PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lilv/trunk/PKGBUILD

require 'package'

class Lilv < Package
  description 'A C library interface to the LV2 plug-in standard'
  homepage 'https://drobilla.net/software/lilv/'
  version '0.24.12'
  license 'isc'
  compatibility 'all'
  source_url 'https://github.com/lv2/lilv.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/lilv-0.24.12-chromeos-armv7l.tpxz',
     armv7l: 'file:///usr/local/tmp/packages/lilv-0.24.12-chromeos-armv7l.tpxz',
       i686: 'file:///usr/local/tmp/packages/lilv-0.24.12-chromeos-i686.tpxz',
     x86_64: 'file:///usr/local/tmp/packages/lilv-0.24.12-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5a0aacc4b651196a40f3be5c7595f819857d200ad0f58f08df94e25978900813',
     armv7l: '5a0aacc4b651196a40f3be5c7595f819857d200ad0f58f08df94e25978900813',
       i686: '2093fbc29b67bdec080e45fbdaf5e410853a4744160331a3b234ff8477fe31e7',
     x86_64: 'b192f661f5a930584a7b0f59e5892dac44248af022e680de15078ab48ea4be66'
  })

  depends_on 'lv2'
  depends_on 'libsndfile' => ':build'
  depends_on 'serd' => ':build'
  depends_on 'sord' => ':build'
  depends_on 'sratom' => ':build'
  depends_on 'swig' => ':build'
  depends_on 'waf' => ':build'

  def self.build
    # let wscript(s) find the custom waf scripts
    FileUtils.mkdir_p 'plugins'
    FileUtils.mv 'waflib/extras', 'plugins/tools'
    FileUtils.ln_s 'plugins/tools', 'tools'
    FileUtils.rm_f 'waflib'
    FileUtils.touch '__init__.py'
    system "sed -e 's/waflib.extras/tools/g' \
    -e \"s/load('autowaf'/load('autowaf', tooldir='tools'/g\" \
    -e \"s/load('lv2'/load('lv2', tooldir='tools'/g\" \
    -i wscript"
    system "waf configure #{CREW_OPTIONS.sub(/--build=.*/, '')}"
    system 'waf -v build'
  end

  def self.install
    system "waf install --destdir=#{CREW_DEST_DIR}"
  end
end
