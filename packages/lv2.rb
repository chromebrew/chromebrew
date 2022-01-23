# Adapted from Arch Linux lv2 PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lv2/trunk/PKGBUILD

require 'package'

class Lv2 < Package
  description 'Plugin standard for audio systems'
  homepage 'http://lv2plug.in/'
  version '1.18.2'
  compatibility 'all'
  source_url 'https://github.com/lv2/lv2.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.2_armv7l/lv2-1.18.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.2_armv7l/lv2-1.18.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.2_i686/lv2-1.18.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lv2/1.18.2_x86_64/lv2-1.18.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '01c2428272130e485d3064a44d580d20b4e08e9523743fde0facde659cf781ec',
     armv7l: '01c2428272130e485d3064a44d580d20b4e08e9523743fde0facde659cf781ec',
       i686: '09972f0e16f7b7b28c412723056b70596f54089143c233fecb01d9c8efb79c57',
     x86_64: 'a70c16a071b6241a21800f83bba960ee3b7f3a8b501748655a1fe32e0e578056'
  })

  depends_on 'gtk2'
  depends_on 'py3_pygments' => :build
  depends_on 'asciidoc' => ':build'
  depends_on 'doxygen' => ':build'
  depends_on 'libsndfile' => ':build'

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
