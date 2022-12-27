require 'package'

class Ruby_mdl < Package
  description 'Style checker/lint tool for markdown files.'
  homepage 'https://github.com/markdownlint/markdownlint'
  version '0.12.0-ruby-3.2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_mdl/0.12.0-ruby-3.2_armv7l/ruby_mdl-0.12.0-ruby-3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_mdl/0.12.0-ruby-3.2_armv7l/ruby_mdl-0.12.0-ruby-3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_mdl/0.12.0-ruby-3.2_i686/ruby_mdl-0.12.0-ruby-3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_mdl/0.12.0-ruby-3.2_x86_64/ruby_mdl-0.12.0-ruby-3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd0b933440d9bb936e7657655db6705a7dc0fda3f18be33951e49cb4c19f9350b',
     armv7l: 'd0b933440d9bb936e7657655db6705a7dc0fda3f18be33951e49cb4c19f9350b',
       i686: '8e7ab1bc27d4c167299986414e49bbcd8320e9b16940262d44774fa854f2554c',
     x86_64: '4d6f1d4f3ea260c64960164e59905e951008b54d11a049f15cbf336033fec290'
  })

  no_fhs
  no_compile_needed

  depends_on 'libyaml'
  depends_on 'ruby'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
  end

  def self.postinstall
    @gem_name = name.sub('ruby_', '')
    system "gem uninstall -Dx --force --abort-on-dependent #{@gem_name}", exception: false
    system "gem install -N #{@gem_name}", exception: false
  end

  def self.remove
    @gem_name = name.sub('ruby_', '')
    @gems_deps = `gem dependency ^#{@gem_name}\$ | awk '{print \$1}'`.chomp
    # Delete the first line and convert to an array.
    @gems = @gems_deps.split("\n").drop(1).append(@gem_name)
    # bundler never gets uninstalled, though gem dependency lists it for
    # every package, so delete it from the list.
    @gems.delete('bundler')
    @gems.each do |gem|
      system "gem uninstall -Dx --force --abort-on-dependent #{gem}", exception: false
    end
  end
end
