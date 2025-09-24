require 'package'

class Btm < Package
  description 'Yet another cross-platform graphical process/system monitor.'
  homepage 'https://clementtsang.github.io/bottom'
  version '0.11.1'
  license 'MIT'
  compatibility 'all'
  min_glibc '2.28' if ARCH.eql?('x86_64')
  source_url({
    aarch64: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_i686-unknown-linux-gnu.tar.gz",
     x86_64: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '7746990396832690e97d465fd040dd4ed7a6ccf0d3db1bfe383a84feac982f4a',
     armv7l: '7746990396832690e97d465fd040dd4ed7a6ccf0d3db1bfe383a84feac982f4a',
       i686: 'b6fe94e41bde3f8b03cf06733a2005e38424ddfef934e6286369b97fe20f7537',
     x86_64: 'b173d13b0206e941b1b646ac18756c63a18fbe8b07744ab8ee992807aa2bad8a'
  })

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.install 'btm', "#{CREW_DEST_PREFIX}/bin/btm", mode: 0o755
    FileUtils.install 'completion/btm.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/btm.bash", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'btm' to get started.\n".lightblue
  end
end
