require 'package'

class Btm < Package
  description 'Yet another cross-platform graphical process/system monitor.'
  homepage 'https://clementtsang.github.io/bottom'
  version '0.10.2'
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
    aarch64: 'aa8d0b3719801a7822c6871e3f6faf207583f170db89eed9a17e79423a25ae7c',
     armv7l: 'aa8d0b3719801a7822c6871e3f6faf207583f170db89eed9a17e79423a25ae7c',
       i686: '7bc7c05a282a430e1a5d82488d7b34204cadd3ee7d4254d0266c63100897fc50',
     x86_64: 'f20211d398b9744545b93ac4af73f3a9f3e67179c385fb0c73d0dd4d84d28a8f'
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
