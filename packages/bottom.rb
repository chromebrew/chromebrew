require 'package'

class Bottom < Package
  description 'Yet another cross-platform graphical process/system monitor.'
  homepage 'https://github.com/ClementTsang/bottom'
  version '0.15.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.28'
  source_url({
    aarch64: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_armv7-unknown-linux-gnueabihf.tar.gz",
     x86_64: "https://github.com/ClementTsang/bottom/releases/download/#{version}/bottom_x86_64-unknown-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '273387b032310c63bc1c3e7cb6a9069fb32a2d20568bfce3b1ba2967dadec1ef',
     armv7l: '273387b032310c63bc1c3e7cb6a9069fb32a2d20568bfce3b1ba2967dadec1ef',
     x86_64: '051888e0e064aa037728efed3fcf77820714f8f4dc7bea2b0179d40c54400c26'
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
