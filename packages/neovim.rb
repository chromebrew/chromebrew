require 'buildsystems/cmake'

class Neovim < CMake
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.11.3'
  license 'Apache-2.0 and vim'
  compatibility 'all'
  source_url 'https://github.com/neovim/neovim.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '405560ae5b698ef74d4d80d42a41fdd8d72d66f2d6497845108e1e3a2421822c',
     armv7l: '405560ae5b698ef74d4d80d42a41fdd8d72d66f2d6497845108e1e3a2421822c',
       i686: '4b9a085bf06fb07e56b3918ebb6977c5ede3260af304d2b9243d664a5a254c59',
     x86_64: '8c7d53547c79c770ff39f1430db9182f8bb4d10c38f44c5df1daae40ca801967'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libluv' # R
  depends_on 'libuv' => :build
  depends_on 'luajit' => :build
  depends_on 'luajit_bitop' => :build
  depends_on 'luajit_lpeg' => :build
  depends_on 'luajit_mpack' => :build
  # depends_on 'perl_app_cpanminus' # L
  depends_on 'tree_sitter' => :build
  depends_on 'unibilium' => :build
  depends_on 'utf8proc' # R
  depends_on 'xdg_base' # L
  depends_on 'luajit_lpeg' # R

  no_lto

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

    @ruby_gem_name = name
    system "gem uninstall -Dx --force --abort-on-dependent #{@ruby_gem_name}", exception: false
    puts 'Installing neovim gem.'.lightblue
    system "gem install -N #{@ruby_gem_name}", exception: false
    puts 'Installing neovim python module. This may take a while...'.lightblue
    system 'pip install neovim', exception: false
    # cpanm install breaks due to failure to install Archive::zip.
    # puts 'Installing neovim perl module. This may take a while...'.lightblue
    # system 'cpanm Neovim::Ext'
  end

  def self.postremove
    @ruby_gem_name = name
    @gems_deps = `gem dependency ^#{@ruby_gem_name}\$ | awk '{print \$1}'`.chomp
    # Delete the first line and convert to an array.
    @gems = @gems_deps.split("\n").drop(1).append(@ruby_gem_name)
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
