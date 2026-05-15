require 'package'

class Edit < Package
  description 'A simple editor for simple needs.'
  homepage 'https://github.com/microsoft/edit'
  version '2.0.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/edit.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33192a2763cd52dce9d73a9bdb1a611e9666e12aec855aebf70b22e97710548a',
     armv7l: '33192a2763cd52dce9d73a9bdb1a611e9666e12aec855aebf70b22e97710548a',
       i686: 'bff933e27ffda8a7536984d96c38d4a53de1f00a651350f4e9d538f371de1e71',
     x86_64: '4aa60ab9ea1e29a9b06023d3a91aaa588fadefba0e25e3d9b6375ed5b0af6794'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'rust' => :build

  def self.build
    system "curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/microsoft/edit/main/assets/install.sh -o install.sh"
    system "sed -i 's,\$tmpdir/edit-src,.,' install.sh"
    system "sed -i '165,203d' install.sh"
    system "sed -i '141d' install.sh"
    system "sed -i '71,72d' install.sh"
    system "sed -i '34,37d' install.sh"
  end

  def self.install
    system 'sh ./install.sh'
    FileUtils.install 'target/release/edit', "#{CREW_DEST_PREFIX}/bin/edit", mode: 0o755
    FileUtils.ln_s "#{CREW_PREFIX}/bin/edit", "#{CREW_DEST_PREFIX}/bin/msedit"
    FileUtils.install 'assets/manpage/edit.1', "#{CREW_DEST_MAN_PREFIX}/man1/edit.1", mode: 0o644
    FileUtils.install 'assets/edit.ico', "#{CREW_DEST_PREFIX}/share/icons/edit.ico", mode: 0o644
    FileUtils.install 'assets/com.microsoft.edit.desktop', "#{CREW_DEST_PREFIX}/share/applications/com.microsoft.edit.desktop", mode: 0o644
  end
end
