require 'package'

class Btm < Package
  description 'Yet another cross-platform graphical process/system monitor.'
  homepage 'https://clementtsang.github.io/bottom'
  version '0.12.3'
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
    aarch64: '42554905f61056d760206a466e3732b348f9fa78221f2dfdb0700d6707661938',
     armv7l: '42554905f61056d760206a466e3732b348f9fa78221f2dfdb0700d6707661938',
       i686: 'e479e7f6e4cfeb96bc6c9045e266e6f5fa1bcdf937fd53d9561171221fc95e24',
     x86_64: '468131d586dee6f4cce23fae597646cfd032103ecf749a478acb9d236adab6d6'
  })

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.install
    FileUtils.install 'btm', "#{CREW_DEST_PREFIX}/bin/btm", mode: 0o755
    FileUtils.install 'completion/btm.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/btm.bash", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'btm' to get started.\n"
  end
end
