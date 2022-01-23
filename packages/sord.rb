# Adapted from Arch Linux sord PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/sord/trunk/PKGBUILD

require 'package'

class Sord < Package
  description 'A lightweight C library for storing RDF data in memory'
  homepage 'https://drobilla.net/software/sord/'
  version '0.16.8'
  compatibility 'all'
  source_url 'https://github.com/drobilla/sord.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.8_armv7l/sord-0.16.8-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.8_armv7l/sord-0.16.8-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.8_i686/sord-0.16.8-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sord/0.16.8_x86_64/sord-0.16.8-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '7b9964ca0db2f500f888dadf4305af8ec0205d54ee2136819abebf553466adf8',
     armv7l: '7b9964ca0db2f500f888dadf4305af8ec0205d54ee2136819abebf553466adf8',
       i686: '21f5b7cacdf491895a4791f1e96c6603ad7b66121a35420931877334476f1b1e',
     x86_64: '3c9d174b7262a07dac584f022ffda1c76f379751ab5f3b75323d19df3425f0ec'
  })

  depends_on 'serd'
  depends_on 'pcre'
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
