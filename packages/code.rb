require 'package'

class Code < Package
  description 'Visual Studio Code is a source code editor developed by Microsoft for Windows, Linux and macOS.'
  homepage 'https://code.visualstudio.com/'
  version '1.36.1'
  source_url 'https://github.com/microsoft/vscode/archive/1.36.1.tar.gz'
  source_sha256 '24b9f4046bd8ef7edb663429a58bf7dbe3acc22487a2946a4e5ead216415c065'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/code-1.36.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: 'cf2b7204aab182cffeafee59972dabf3306754c3d158811492dff39f0959e2ab',
  })

  depends_on 'nodebrew'
  depends_on 'yarn' => :build
  depends_on 'gtk2'
  depends_on 'ld_default'
  depends_on 'libsecret'
  depends_on 'libgconf'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  case ARCH
  when 'armv7l', 'aarch64'
    @arch = 'arm'
  when 'i686'
    @arch = 'ia32'
  when 'x86_64'
    @arch = 'x64'
  end

  ENV['PATH'] = "#{ENV['HOME']}/.nodebrew/current/bin:#{ENV['PATH']}"
  ENV['LIBRARY_PATH'] = CREW_LIB_PREFIX

  def self.build
    old_ld = `ld_default b`.chomp
    node_ver = 'v10.16.0'
    node_ver = 'v9.11.2' if ARCH == 'i686'
    node_old = `nodebrew ls | fgrep 'current: ' | cut -d' ' -f2`.chomp
    node_ver_installed = `nodebrew ls | grep -o #{node_ver} | head -1`.chomp
    system "nodebrew install #{node_ver}" unless node_ver_installed == node_ver
    system "nodebrew use #{node_ver}" unless node_old == node_ver
    system 'npm install gulp'
    system 'yarn install'
    system "yarn run gulp vscode-linux-#{@arch}"
    system "nodebrew uninstall #{node_ver}" unless node_ver_installed == node_ver
    system "nodebrew use #{node_old}" unless node_old == "none"
    system 'ld_default', "#{old_ld}"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system 'mv', "../VSCode-linux-#{@arch}", "#{CREW_DEST_PREFIX}/share/code"
    system "sed -i -e '/CLI=/d' -e 's,\"\\$CLI\" ,,g' -e 's,ELECTRON_RUN_AS_NODE=1 ,,g' #{CREW_DEST_PREFIX}/share/code/bin/code-oss"
    system "sed -i '42iGDK_BACKEND=x11' #{CREW_DEST_PREFIX}/share/code/bin/code-oss"
    system 'ln', '-s', '../share/code/bin/code-oss', "#{CREW_DEST_PREFIX}/bin/code"
    system 'ln', '-s', '../share/code/bin/code-oss', "#{CREW_DEST_PREFIX}/bin/code-oss"
    # Add the Marketplace for extensions.
    system "sed -i '30,31d' #{CREW_DEST_PREFIX}/share/code/resources/app/product.json"
    system "cat << 'EOF' >> #{CREW_DEST_PREFIX}/share/code/resources/app/product.json
	},
	\"extensionsGallery\": {
		\"serviceUrl\": \"https://marketplace.visualstudio.com/_apis/public/gallery\",
		\"cacheUrl\": \"https://vscode.blob.core.windows.net/gallery/index\",
		\"itemUrl\": \"https://marketplace.visualstudio.com/items\"
	}
}
EOF"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed Visual Studio Code on Chrome OS!'.lightgreen
    puts 'Now, please run \'code-oss\' to start Code.'.lightgreen
    puts 'Happy coding!'.lightgreen
    puts
  end
end
