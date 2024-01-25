require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.8.2'
  license 'Apache-2.0 and vim'
  compatibility 'all'
  source_url 'https://github.com/neovim/neovim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e5bcc8ada8eedcd5603c7061860dd56aef16171667fc97d6279d6c17bf25385',
     armv7l: '8e5bcc8ada8eedcd5603c7061860dd56aef16171667fc97d6279d6c17bf25385',
       i686: '4fff03cc692bc7875f5c25d6a108a12226b7cc4df17a685ed79661aaa1578f08',
     x86_64: '111ec2f1175b8074b48d6cf6b0720ab657ffc3e27d83166400d11cd8e506d2eb'
  })

  depends_on 'glibc' # R
  depends_on 'libluv' # R
  depends_on 'libtermkey' # R
  depends_on 'libuv' => :build
  depends_on 'libvterm' # R
  depends_on 'luajit_bitop' => :build
  depends_on 'luajit_lpeg' => :build
  depends_on 'luajit_mpack' => :build
  depends_on 'luajit' # R
  depends_on 'msgpack_c' # R
  # depends_on 'perl_app_cpanminus' # L
  depends_on 'tree_sitter' # R
  depends_on 'unibilium' => :build
  depends_on 'xdg_base'

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.postinstall
    # Set nvim to be the default vi if there is no vi or if a default
    # vi does not exist.
    @crew_vi = File.file?("#{CREW_PREFIX}/bin/vi")
    @system_vi = File.file?('/usr/bin/vi')
    @create_vi_symlink = true if !@system_vi && !@crew_vi
    @create_vi_symlink_ask = true if @crew_vi || @system_vi
    if @create_vi_symlink_ask
      print "\nWould you like to set nvim to be the default vi [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        @create_vi_symlink = true
      else
        @create_vi_symlink = false
        puts 'Default vi left unchanged.'.lightgreen
      end
    end
    if @create_vi_symlink
      FileUtils.ln_sf "#{CREW_PREFIX}/bin/nvim", "#{CREW_PREFIX}/bin/vi"
      puts 'Default vi set to nvim.'.lightgreen
    end

    @gem_name = name
    system "gem uninstall -Dx --force --abort-on-dependent #{@gem_name}", exception: false
    puts 'Installing neovim gem.'.lightblue
    system "gem install -N #{@gem_name}", exception: false
    puts 'Installing neovim python module. This may take a while...'.lightblue
    system 'pip install neovim', exception: false
    # cpanm install breaks due to failure to install Archive::zip.
    # puts 'Installing neovim perl module. This may take a while...'.lightblue
    # system 'cpanm Neovim::Ext'
  end

  def self.remove
    @gem_name = name
    @gems_deps = `gem dependency ^#{@gem_name}\$ | awk '{print \$1}'`.chomp
    # Delete the first line and convert to an array.
    @gems = @gems_deps.split("\n").drop(1).append(@gem_name)
    # bundler never gets uninstalled, though gem dependency lists it for
    # every package, so delete it from the list.
    @gems.delete('bundler')
    @gems.each do |gem|
      system "gem uninstall -Dx --force --abort-on-dependent #{gem}", exception: false
    end
    system 'pip uninstall neovim -y', exception: false
    # system 'cpanm --uninstall Neovim::Ext'
    # Remove vi symlink if it is to nvim.
    return unless File.symlink?("#{CREW_PREFIX}/bin/vi") && (File.readlink("#{CREW_PREFIX}/bin/vi") == "#{CREW_PREFIX}/bin/nvim")

    FileUtils.rm "#{CREW_PREFIX}/bin/vi"
  end
end
