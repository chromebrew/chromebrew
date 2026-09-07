require 'package'

class Bottom < Package
  description 'Yet another cross-platform graphical process/system monitor.'
  homepage 'https://github.com/ClementTsang/bottom'
  version '0.14.9'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'a9c1aa0a12d6f6fcbd7948c4dc50504504c916ad1ef4ed0219483e64fbe03038',
     armv7l: 'a9c1aa0a12d6f6fcbd7948c4dc50504504c916ad1ef4ed0219483e64fbe03038',
     x86_64: 'e0c325829e8bdcea25a8a7651da05dbb6f1fc109ac5d2f0187867d3d5d9c0df8'
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
