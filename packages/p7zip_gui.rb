# Adapted from Arch Linux p7zip-gui PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=p7zip-gui

require 'package'

class P7zip_gui < Package
  description 'Graphic user interface (alpha quality) for the 7-zip file archiver'
  homepage 'http://p7zip.sourceforge.net/'
  version '16.02'
  license 'LGPL-2.1 and unRAR'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2'
  source_sha256 '5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f'

  depends_on 'wxwidgets'

  case ARCH
  when 'x86_64'
    depends_on 'yasm' => :build # needed for compiling the faster asm binary
    @_makefile = 'makefile.linux_amd64_asm'
  when 'i686'
    depends_on 'nasm' => :build # needed for compiling the faster asm binary
    @_makefile = 'makefile.linux_x86_asm_gcc_4.X'
  else
    @_makefile = 'makefile.linux_any_cpu'
  end

  def self.patch
    aur_github_url = 'https://raw.githubusercontent.com/archlinux/svntogit-packages'
    patches = {
      'https://src.fedoraproject.org/rpms/p7zip/raw/rawhide/f/14-Fix-g++-warning.patch' => 'a923c8876f36201064b0efabbc2121e47cf7a78a0700d3974ef24ab3a05bd88a',
       "#{aur_github_url}/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2016-9296.patch" => 'f9bcbf21d4aa8938861a6cba992df13dec19538286e9ed747ccec6d9a4e8f983',
      "#{aur_github_url}/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2017-17969.patch" => 'c6af5ba588b8932a5e99f3741fcf1011b7c94b533de903176c7d1d4c02a9ebef',
       "#{aur_github_url}/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2018-5996.patch" => '9c92b9060fb0ecc3e754e6440d7773d04bc324d0f998ebcebc263264e5a520df',
      "#{aur_github_url}/a82b67f5d36f374afd154e7648bb13ec38a3c497/trunk/CVE-2018-10115.patch" => 'c397eb6ad60bfab8d388ea9b39c0c13ae818f86746210c6435e35b35c786607f',
              'https://src.fedoraproject.org/rpms/p7zip/raw/rawhide/f/gcc10-conversion.patch' => 'f90013d66d3c9865cb56fed2fb0432057a07283d5361e2ae9e98c3d3657f42a1'
    }

    puts 'Downloading patches...'

    patches.each do |url, sha256sum|
      patch_filename = File.basename(url)

      downloader url, sha256sum, patch_filename

      system 'patch', '-p1', '-i', patch_filename
    end

    system 'sed', '-i', 's/_do_not_use//g', 'Utils/generate.py'
    system 'sed', '-i', 's,^#!.*,#!/usr/bin/env bash,', 'GUI/p7zipForFilemanager'
  end

  def self.build
    @_desktop_entry = <<~EOF.gsub(/(?<=;) */, '')
      [Desktop Entry]
      Encoding=UTF-8
      Name=7-Zip File Manager
      GenericName=7-Zip File Manager
      Type=Application
      Categories=GTK;Utility;Archiving;Compression;
      Terminal=false
      Icon=p7zip
      Exec=7zFM
      NoDisplay=false
      MimeType=application/gzip; \
        application/x-7z-compressed; \
        application/x-7z-compressed-tar; \
        application/x-arj; \
        application/x-bzip; \
        application/x-bzip-compressed-tar; \
        application/x-bzip1; \
        application/x-bzip1-compressed-tar; \
        application/x-cabinet; \
        application/x-cd-image; \
        application/x-compress; \
        application/x-compressed-tar; \
        application/x-cpio; \
        application/x-deb; \
        application/x-gtar; \
        application/x-gzip; \
        application/x-gzpostscript; \
        application/x-lha; \
        application/x-lhz; \
        application/x-lzma; \
        application/x-lzma-compressed-tar; \
        application/x-ms-wim; \
        application/x-rar; \
        application/x-rar-compressed; \
        application/x-rpm; \
        application/x-tar; \
        application/x-xz; \
        application/x-xz-compressed-tar; \
        application/x-zip; \
        application/x-zip-compressed; \
        application/zip; \
        application/vnd.ms-cab-compressed;
    EOF

    system './generate.py', chdir: 'Utils/'

    FileUtils.cp @_makefile, 'makefile.machine'
    system 'make', '7zFM', '7zG'
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/share/icons/hicolor/32x32/apps", "#{CREW_DEST_PREFIX}/share/applications"]

    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "DEST_DIR=#{CREW_DEST_DIR}", "DEST_MAN=#{CREW_MAN_PREFIX}", 'install'

    File.write "#{CREW_DEST_PREFIX}/share/applications/7zFM.desktop", @_desktop_entry

    FileUtils.chmod 0o755, "#{CREW_DEST_PREFIX}/share/applications/7zFM.desktop"
    FileUtils.chmod 0o755, "#{CREW_DEST_PREFIX}/bin/p7zipForFilemanager"

    # use 7z.so provided by package 7_zip
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/7z.so", "#{CREW_DEST_PREFIX}/lib/p7zip/7z.so"
    FileUtils.install 'GUI/p7zip_32.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/32x32/apps/p7zip.png"
  end

  def self.postinstall
    puts <<~EOT
      Type '7zFM <archive>' to open an archive in p7zip GUI.
    EOT
  end
end
