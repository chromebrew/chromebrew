require 'package'

class Ruby_yaml_lint < Package
  description 'Check if your YAML files can be loaded.'
  homepage 'https://rubygems.org/gems/yaml-lint'
  version '0.0.10-ruby-3.2'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_yaml_lint/0.0.10-ruby-3.2_armv7l/ruby_yaml_lint-0.0.10-ruby-3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_yaml_lint/0.0.10-ruby-3.2_armv7l/ruby_yaml_lint-0.0.10-ruby-3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_yaml_lint/0.0.10-ruby-3.2_i686/ruby_yaml_lint-0.0.10-ruby-3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ruby_yaml_lint/0.0.10-ruby-3.2_x86_64/ruby_yaml_lint-0.0.10-ruby-3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '11e815a4d7ed0bd6a43da6a68ffdb2be25ce0e0ecbac26a1c04bbba0981b2ba2',
     armv7l: '11e815a4d7ed0bd6a43da6a68ffdb2be25ce0e0ecbac26a1c04bbba0981b2ba2',
       i686: '5405ecb8ff7233c1a58cea9cdaef6e06a4660c5ab07685381a92d6670016e1a5',
     x86_64: '28ed4bd9e89bb1c8afc563e603693aa10c0d14e3756d02629d64f0c36967bd45'
  })

  no_fhs
  no_compile_needed

  depends_on 'libyaml'
  depends_on 'ruby'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
  end

  def self.postinstall
    @gem_name = name.sub('ruby_', '').sub('_', '-')
    system "gem uninstall -Dx --force --abort-on-dependent #{@gem_name}", exception: false
    system "gem install -N #{@gem_name}", exception: false
  end

  def self.remove
    @gem_name = name.sub('ruby_', '').sub('_', '-')
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
