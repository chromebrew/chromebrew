require 'buildsystems/meson'

class Megatools < Meson
  description 'Megatools is a collection of programs for accessing Mega.nz service from a command line of your desktop or server.'
  homepage 'https://megatools.megous.com/'
  version '1.11.5.20250706'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://xff.cz/megatools/builds/megatools-#{version}.tar.gz"
  source_sha256 '51f78a03748a64b1066ce28a2ca75d98dbef5f00fe9789dc894827f9a913b362'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '236286635d377470423b68f8996a11e7083333d8ce281b86fbb8f5207f22f0ef',
     armv7l: '236286635d377470423b68f8996a11e7083333d8ce281b86fbb8f5207f22f0ef',
       i686: '4c63d58ca40e839d7797e62a00effaff2b7169dbab8dc65d521f4604c40b49db',
     x86_64: 'a6e15ca98f51159bec6359bed1c7b3ec7f085397cc1090243c19ad82b97ad073'
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
