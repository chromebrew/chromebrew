require 'buildsystems/meson'

class Megatools < Meson
  description 'Megatools is a collection of programs for accessing Mega.nz service from a command line of your desktop or server.'
  homepage 'https://megatools.megous.com/'
  version '1.12.2.20261116'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://xff.cz/megatools/builds/megatools-#{version}.tar.gz"
  source_sha256 '2c8cfbb41eabf1ffac92f08f5b3aecb361bcfb9c02ac258769fb5e3ba2f15b84'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d631da30882ca246ba8068d8339a1bc8fd20d1507145c70a4473bc4fc87c039',
     armv7l: '1d631da30882ca246ba8068d8339a1bc8fd20d1507145c70a4473bc4fc87c039',
       i686: '692041de125a0c0bde00dc735941f30c856225c5e766bdee83658f9706935818',
     x86_64: 'c7ad6f79a47e4fe7f75a516471ba1be36b76f9b4721b3af8796b478da08c629f'
  })

  depends_on 'curl' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'openssl' => :executable
  depends_on 'txt2man' => :build

  print_source_bashrc

  meson_install_extras do
    FileUtils.install 'contrib/bash-completion/megatools', "#{CREW_DEST_PREFIX}/etc/bash.d/10-megatools", mode: 0o644
    Dir["#{CREW_DEST_PREFIX}/bin/*"].each do |binary|
      bin = File.basename(binary)
      man = "#{bin}.1"
      system "#{binary} -h | txt2man -r #{bin}-#{version} -s 1 -t #{bin} > #{man}"
      FileUtils.install man, "#{CREW_DEST_MAN_PREFIX}/man1/#{man}", mode: 0o644
    end
    Dir.chdir 'docs' do
      system "txt2man -r megarc-#{version} -s 5 -t megarc megarc.txt > megarc.5"
      FileUtils.install 'megarc.5', "#{CREW_DEST_MAN_PREFIX}/man5/megarc.5", mode: 0o644
    end
  end
end
