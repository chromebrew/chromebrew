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
    aarch64: '28d808ac53f478f07b4a7655e82a5060dbe90b5c51da50b159468d2182e5d0c4',
     armv7l: '28d808ac53f478f07b4a7655e82a5060dbe90b5c51da50b159468d2182e5d0c4',
       i686: 'e4a63625346999e7b5dff108a9bcabac3d3f1bcc934dc1161a070eeacf69b360',
     x86_64: '81d800d7fb0f621fd2763a90f400a0df69a8f5972a977767bdc7738675274d4d'
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

  meson_options "-Droot-dir=#{CREW_PREFIX} \
             -Dsysconfdir=#{CREW_PREFIX}/etc \
             -Dlocalstatedir=#{CREW_PREFIX}/var \
             -Dsharedstatedir=#{CREW_PREFIX}/var/local/lib \
             -Dmakepkg-template-dir=#{CREW_PREFIX}/share/makepkg-template \
             -Dscriptlet-shell=#{CREW_PREFIX}/bin/bash \
             -Dldconfig=/sbin/ldconfig \
             -Dpkg-ext=.pkg.tar.xz \
             -Dsrc-ext=.src.tar.gz"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    # Enable mirror list.
    open("#{CREW_DEST_PREFIX}/etc/pacman.conf", 'a') do |f|
      f.puts '[core]'
      f.puts 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch'
      f.puts "Include = #{CREW_PREFIX}/etc/pacman.d/mirrorlist"
      f.puts '[extra]'
      f.puts "Include = #{CREW_PREFIX}/etc/pacman.d/mirrorlist"
      f.puts '[community]'
      f.puts "Include = #{CREW_PREFIX}/etc/pacman.d/mirrorlist"
    end
    # Figure out how to enable trusts for the gpg sigs...
    system "sed -i '/#SigLevel/a SigLevel = TrustAll' #{CREW_DEST_PREFIX}/etc/pacman.conf"
    downloader 'https://archlinux.org/mirrorlist/all/', 'SKIP', 'mirrorlist'
    # Uncomment worldwide mirror in mirror list.
    system "sed -i ':a;N;$!ba;s/## Worldwide\\\n#Server/## Worldwide\\\nServer/' mirrorlist"
    FileUtils.install 'mirrorlist', "#{CREW_DEST_PREFIX}/etc/pacman.d/mirrorlist", mode: 0o644
  end

  def self.postinstall
    puts 'Updating pacman mirrorlist.'.lightblue
    downloader 'https://archlinux.org/mirrorlist/all/', 'SKIP', 'mirrorlist'
    # Uncomment worldwide mirror in mirror list.
    system "sed -i ':a;N;$!ba;s/## Worldwide\\\n#Server/## Worldwide\\\nServer/' mirrorlist"
    FileUtils.install 'mirrorlist', "#{CREW_PREFIX}/etc/pacman.d/mirrorlist", mode: 0o644
    puts 'Please run: sudo pacman-key --init ; sudo pacman -Syu'.orange
  end
end
