# Adapted from Arch Linux serd PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/serd/trunk/PKGBUILD

require 'package'

class Serd < Package
  description 'Lightweight C library for RDF syntax supporting reading/ writing Turtle and NTriples.'
  homepage 'https://drobilla.net/software/serd/'
  version '0.30.10'
  compatibility 'all'
  source_url 'https://github.com/drobilla/serd.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/serd-0.30.10-chromeos-armv7l.tpxz',
     armv7l: 'file:///usr/local/tmp/packages/serd-0.30.10-chromeos-armv7l.tpxz',
       i686: 'file:///usr/local/tmp/packages/serd-0.30.10-chromeos-i686.tpxz',
     x86_64: 'file:///usr/local/tmp/packages/serd-0.30.10-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '18bdc58281fc31baff1ad0fc464b70c78f8becd1b4efee39c1cddc17e419a88c',
     armv7l: '18bdc58281fc31baff1ad0fc464b70c78f8becd1b4efee39c1cddc17e419a88c',
       i686: '20f1dc846a679857ba27e234bd1a13dd546f568f2c749ec2f5d4bfcc3f421da3',
     x86_64: '9d44f52a0f18e146458ccb8ef8478be1cba0e1fcd1d1ed76743bbd10d861bb4d'
  })

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
