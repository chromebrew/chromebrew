require 'buildsystems/cmake'

class Neovim < CMake
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.9.5'
  license 'Apache-2.0 and vim'
  compatibility 'all'
  source_url 'https://github.com/neovim/neovim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efc5b03dbb0e6f0292030dea2ec89294690e6bca471b6a559329d13cc92ea13a',
     armv7l: 'efc5b03dbb0e6f0292030dea2ec89294690e6bca471b6a559329d13cc92ea13a',
       i686: 'f5e44f127df3329a837cb56fa70f547cdeda8fc3ea7d873dbc7c9a5a6e7b6d45',
     x86_64: '97a127932ead9fdf64640c582205f9efe94f384b9803cf122553c84ce19a1d3b'
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
  depends_on 'xdg_base' # L

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
