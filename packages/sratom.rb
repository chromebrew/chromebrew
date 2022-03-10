# Adapted from Arch Linux sratom PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/sratom/trunk/PKGBUILD

require 'package'

class Sratom < Package
  description 'An LV2 Atom RDF serialisation library'
  homepage 'https://drobilla.net/software/sratom/'
  version '0.6.8'
  compatibility 'all'
  source_url 'https://github.com/lv2/sratom.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.8_armv7l/sratom-0.6.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.8_armv7l/sratom-0.6.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.8_i686/sratom-0.6.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sratom/0.6.8_x86_64/sratom-0.6.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'be65f506b6d36f893747ac861707f6ae8608bc87680b0534c201823c5cd8b039',
     armv7l: 'be65f506b6d36f893747ac861707f6ae8608bc87680b0534c201823c5cd8b039',
       i686: '9e8908eac3420f94280b1f6e5680b196a95ba389ad3eb5499cf438aea34b16e6',
     x86_64: 'e8a1f9a860e7b0a1e64c5311a9d02e28ee27b39e66fb271e25998fafe9b95169'
  })

  depends_on 'lv2'
  depends_on 'serd' => :build
  depends_on 'sord' => :build
  depends_on 'waf' => :build

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
