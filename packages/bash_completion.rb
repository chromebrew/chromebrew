require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.11-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion/archive/refs/tags/2.11.tar.gz'
  source_sha256 '16adefabf43ec8ffb473704f5724d775c2f47e9f750d7d608f0251ec21fe8813'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f08fa79964a1f0077f8c523ab3f72afcf287bab069aae3c475ef49a515689508',
     armv7l: 'f08fa79964a1f0077f8c523ab3f72afcf287bab069aae3c475ef49a515689508',
       i686: '3a8cd80d863f72a2f88fa27e4cdce054c9133361cfcea693c8fa23ddd3b692d1',
     x86_64: 'ff8dce6b4da22853b8e558cbf814ed86fd1793b39a0123f64569cd09f80af27f'
  })

  def self.build
    system 'autoreconf -i'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
