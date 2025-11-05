require 'package'

class Depot_tools < Package
  description 'Chromium uses a package of scripts, the depot_tools, to manage interaction with the Chromium source code repository and the Chromium development process.'
  homepage 'https://dev.chromium.org/developers/how-tos/depottools'
  version '240cd0'
  license 'BSD-Google'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromium/tools/depot_tools.git'
  git_hashtag '240cd02c2939a4eaa2c632d12595f5b6d51d5c91'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8d722dd31fd416f7b18f6ea13531e91076683e4884d9a7a843a820bdb8795cfe',
     armv7l: '8d722dd31fd416f7b18f6ea13531e91076683e4884d9a7a843a820bdb8795cfe',
       i686: '6fa7cf642fb04597b232870f1a3d7d45ff0991c1a813a6f5a00412c5bd0ee815',
     x86_64: 'afc31123fe5e642ef24b264fdaba9038d3eb953eb8769c460bc2fa5be8153b44'
  })

  depends_on 'xdg_base'

  def self.install
    system "git checkout #{version}"
    FileUtils.rm_rf 'man/src/'
    FileUtils.rm_rf Dir['.git*', '**/*.bat']
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/depot_tools/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/doc/depot_tools/"
    FileUtils.mv Dir.glob('man/html/*.html'), "#{CREW_DEST_PREFIX}/share/doc/depot_tools/"
    FileUtils.mv Dir.glob('man/*'), CREW_DEST_MAN_PREFIX
    FileUtils.rm_r 'man/'
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/depot_tools"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/.vpython-root"
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/.vpython_cipd_cache"
    FileUtils.ln_s "#{HOME}/.config/.vpython-root/", "#{CREW_DEST_HOME}/.vpython-root"
    FileUtils.ln_s "#{HOME}/.config/.vpython_cipd_cache/", "#{CREW_DEST_HOME}/.vpython_cipd_cache"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    @depot_tools_env = <<~DEPOT_TOOLS_EOF
      # Add depot-tools to path
      PATH="$PATH:#{CREW_PREFIX}/share/depot_tools"
    DEPOT_TOOLS_EOF
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/depot_tools", @depot_tools_env)
  end

  def self.postremove
    FileUtils.rm_rf Dir["#{HOME}/.config/.vpython*"]
  end
end
