require 'package'

class Lmstudio < Package
  description 'Discover, download, and run local LLMs'
  homepage 'https://lmstudio.ai/'
  version '0.2.17-preview-6'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://releases.lmstudio.ai/linux/0.2.17/test/LM_Studio-0.2.17-preview-6.AppImage'
  source_sha256 '6da83495bfb64d46f317512cbe430e71b8119daaf6ffd0329b649d7098dad5ba'

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'harfbuzz' # R
  depends_on 'cups' # R
  depends_on 'dbus' # R
  depends_on 'dbus_glib' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibc_lib' # R
  depends_on 'gtk2' # R
  depends_on 'gtk3' # R
  depends_on 'libdrm' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrandr' # R
  depends_on 'mesa' # R
  depends_on 'nss' # R
  depends_on 'opencl_icd_loader' # R
  depends_on 'pango' # R
  depends_on 'gdk_base' # R
  depends_on 'sommelier' # R

  no_shrink
  no_compile_needed

  def self.build
    File.write 'lmstudio.sh', <<~EOF
      #!/bin/bash
      rm -f "#{HOME}/.cache/lm-studio/gpu-preferences.json"
      cd #{CREW_PREFIX}/share/lmstudio
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.rm 'lm-studio.png'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/lmstudio"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'lm-studio.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'lmstudio.sh', "#{CREW_DEST_PREFIX}/bin/lmstudio", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/lmstudio"
  end

  def self.postinstall
    puts "\nType 'lmstudio' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.cache/lm-studio"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
