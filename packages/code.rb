require 'package'

class Code < Package

  case ARCH
  when 'x86_64'
    @arch = 'x64'
  when 'i686'
    @arch = 'ia32'
  when 'armv7l', 'aarch64'
    @arch = 'arm'
  end

  description 'Visual Studio Code is a source code editor developed by Microsoft for Windows, Linux and macOS.'
  homepage 'https://code.visualstudio.com/'
  version '1.30.1-1'
  source_url "https://github.com/Microsoft/vscode/archive/1.30.1.tar.gz"
  source_sha256 'bf558c2818159fd2a47fa80c882794505b5d73d118f94f46d09c98b388d9e203'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'nodebrew'
  depends_on 'yarn' => :build
  depends_on 'gtk2'
  depends_on 'libsecret'
  depends_on 'libgconf'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  ENV['PATH'] = "#{ENV['HOME']}/.nodebrew/current/bin:#{ENV['PATH']}"

  def self.build
    node_ver = "v8.15.0"
    node_old = `nodebrew ls | fgrep 'current: ' | cut -d' ' -f2`.chomp
    node_ver_installed = `nodebrew ls | grep -o #{node_ver} | head -1`.chomp
    system "nodebrew install #{node_ver}" unless "#{node_ver_installed}" == "#{node_ver}"
    system "nodebrew use #{node_ver}" unless "#{node_old}" == "#{node_ver}"
    system "npm install gulp"
    system "yarn install"
    system "yarn run gulp vscode-linux-#{@arch}"
    system "nodebrew uninstall #{node_ver}" unless "#{node_ver_installed}" == "#{node_ver}"
    system "nodebrew use #{node_old}" unless "#{node_old}" == "none"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "mv", "../VSCode-linux-#{@arch}", "#{CREW_DEST_PREFIX}/share/code"
    system "sed -i -e 's,ELECTRON_RUN_AS_NODE=1 ,,g' #{CREW_DEST_PREFIX}/share/code/bin/code-oss"
    # ^^^ Do not remove this line.
    system "ln", "-s", "../share/code/bin/code-oss", "#{CREW_DEST_PREFIX}/bin/code"
    system "ln", "-s", "../share/code/bin/code-oss", "#{CREW_DEST_PREFIX}/bin/code-oss"
  end

  def self.postinstall
    puts
    puts 'Congratulations! You have installed Visual Studio Code on Chrome OS!'.lightgreen
    puts 'Now, please run \'code-oss\' to start Visual Studio.'.lightgreen
    puts 'Happy coding!'.lightgreen
    puts
  end
end
