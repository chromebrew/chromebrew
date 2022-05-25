require 'package'

class Vuze < Package
  description 'Vuze (formerly Azureus) is an extremely powerful and configurable BitTorrent client.'
  homepage 'https://www.vuze.com/'
  version '5.7.6.0'
  license 'GPLv2'
  compatibility 'x86_64'
  source_url 'https://downloads.sourceforge.net/project/azureus/vuze/Vuze_5760/Vuze_5760_linux.tar.bz2'
  source_sha256 '1c5995ed8a25bac4bf1cea012b583af92af04c15579ab686689bca13e6cad36c'
  binary_compression 'tar.xz'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vuze/5.7.6.0_x86_64/vuze-5.7.6.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    x86_64: '062957f74835d906c6788056224dda734b92e64473a4ac330afbd29041d71c74'
  })

  depends_on 'jdk8'
  depends_on 'gtk3'

  def self.patch
    system "sed -i 's,~/azScript,#{CREW_PREFIX}/tmp/azScript,g' vuze"
  end

  def self.build
    vuze = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/vuze
      ./vuze "$@"
    EOF
    File.write('vuze.sh', vuze)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.azureus"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/vuze"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applicatons"
    FileUtils.mv ['vuze.desktop', 'vuze.png'], "#{CREW_DEST_PREFIX}/share/applicatons"
    FileUtils.install 'vuze.sh', "#{CREW_DEST_PREFIX}/bin/vuze", mode: 0o755
    FileUtils.rm 'vuze.sh'
    FileUtils.cp_r 'plugins', "#{CREW_DEST_HOME}/.azureus"
    FileUtils.cp_r Dir['.'], "#{CREW_DEST_PREFIX}/share/vuze"
    libraries = ['libswt-gtk-4716.so',
                 'libswt-atk-gtk-4716.so',
                 'libswt-cairo-gtk-4716.so',
                 'libswt-pi-gtk-4716.so',
                 'libswt-pi3-gtk-4716.so',
                 'libswt-webkit-gtk-4716.so']
    libraries.each do |_lib|
      system './vuze'
      FileUtils.cp Dir["#{HOME}/.swt/lib/linux/x86_64/libswt-*"], "#{CREW_DEST_PREFIX}/share/vuze"
    end
  end

  def self.postinstall
    puts "\nType 'vuze' to get started.\n".lightblue
  end

  def self.remove
    config_dirs = ["#{HOME}/.azureus", "#{HOME}/.swt"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      system "echo '#{config_dir}'; ls '#{config_dir}'"
    end
    print "\nWould you like to remove the config directories above? [y/N] "
    case $stdin.gets.chomp.downcase
    when 'y', 'yes'
      config_dirs.each do |config_dir|
        next unless Dir.exist? config_dir

        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      end
    else
      puts 'Configuration saved.'.lightgreen
    end
  end
end
