require 'buildsystems/meson'

class Pacman < Meson
  description 'A library-based package manager with dependency support.'
  version '6.0.2-1'
  homepage 'http://www.archlinux.org/pacman/'
  license 'GPL 2'
  compatibility 'all'
  source_url 'https://sources.archlinux.org/other/pacman/pacman-6.0.2.tar.xz'
  source_sha256 '7d8e3e8c5121aec0965df71f59bedf46052c6cf14f96365c4411ec3de0a4c1a5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2-1_armv7l/pacman-6.0.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2-1_armv7l/pacman-6.0.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2-1_i686/pacman-6.0.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pacman/6.0.2-1_x86_64/pacman-6.0.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6fbcdb729f914046f7b71b4eb9c7142805a2492f3993902165fc46120367ac86',
     armv7l: '6fbcdb729f914046f7b71b4eb9c7142805a2492f3993902165fc46120367ac86',
       i686: '8454c139754b140caa72cac7e64e07cff387d506a453a00fa04d16c0547fd5d7',
     x86_64: '204720233fd56e0de7c29b90dcf3bbcad7e22fa07b9b9d1e7c5902f50e903984'
  })

  depends_on 'asciidoc' => :build
  depends_on 'bash' # pacman demands a bash newer than 4.0
  depends_on 'curl' # R
  depends_on 'fakeroot' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gpgme' # R
  depends_on 'libarchive' # R
  depends_on 'openssl' # R
  depends_on 'py3_setuptools' => :build # needed for Python 3.12 compatibility
  depends_on 'xzutils' # L

  def self.patch
    FileUtils.touch 'pacman.conf'
    FileUtils.install 'pacman.conf', "#{CREW_DEST_PREFIX}/etc/pacman.conf", mode: 0o644
    downloader 'https://archlinux.org/mirrorlist/all/', 'SKIP', 'mirrorlist'
    # Uncomment worldwide mirror in mirror list.
    system "sed -i ':a;N;$!ba;s/## Worldwide\\\n#Server/## Worldwide\\\nServer/' mirrorlist"
    FileUtils.install 'mirrorlist', "#{CREW_DEST_PREFIX}/etc/pacman.d/mirrorlist", mode: 0o644
  end

  meson_options "-Droot-dir=#{CREW_PREFIX} \
             -Dsysconfdir=#{CREW_PREFIX}/etc \
             -Dlocalstatedir=#{CREW_PREFIX}/var \
             -Dsharedstatedir=#{CREW_PREFIX}/var/local/lib \
             -Dmakepkg-template-dir=#{CREW_PREFIX}/share/makepkg-template \
             -Dscriptlet-shell=#{CREW_PREFIX}/bin/bash \
             -Dldconfig=/sbin/ldconfig \
             -Dpkg-ext=.pkg.tar.xz \
             -Dsrc-ext=.src.tar.gz"

  def self.postinstall
    # Enable mirror list.
    open("#{CREW_PREFIX}/etc/pacman.conf", 'a') do |f|
      f.puts '[core]'
      f.puts 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch'
      f.puts "Include = #{CREW_PREFIX}/etc/pacman.d/mirrorlist"
      f.puts '[extra]'
      f.puts "Include = #{CREW_PREFIX}/etc/pacman.d/mirrorlist"
      f.puts '[community]'
      f.puts "Include = #{CREW_PREFIX}/etc/pacman.d/mirrorlist"
    end
    # Figure out how to enable trusts for the gpg sigs...
    system "sed -i '/#SigLevel/a SigLevel = TrustAll' #{CREW_PREFIX}/etc/pacman.conf"
    puts 'Updating pacman mirrorlist.'.lightblue
    downloader 'https://archlinux.org/mirrorlist/all/', 'SKIP', 'mirrorlist'
    # Uncomment worldwide mirror in mirror list.
    system "sed -i ':a;N;$!ba;s/## Worldwide\\\n#Server/## Worldwide\\\nServer/' mirrorlist"
    FileUtils.install 'mirrorlist', "#{CREW_PREFIX}/etc/pacman.d/mirrorlist", mode: 0o644
    puts 'Please run: sudo pacman-key --init ; sudo pacman -Syu'.orange
  end
end
