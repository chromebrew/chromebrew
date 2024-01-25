require 'package'

class Deployer < Package
  description 'A deployment tool for PHP'
  homepage 'https://deployer.org/'
  version '6.7.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/deployphp/deployer/archive/v6.7.3.tar.gz'
  source_sha256 '81e5cea09f68b898d72a52ea6c4401fbc4cc1bc2fc30d488acce6e8fdef59d79'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'e5a87eefab63f035398a2cfd2d4682ae6e95dc608c405242da8c60bcce2798db',
     armv7l: 'e5a87eefab63f035398a2cfd2d4682ae6e95dc608c405242da8c60bcce2798db',
       i686: 'c68fad1a58417c09c4c1c49a2c474641378027a83e98ad159ca53780311d160e',
     x86_64: '57f072d4617d8dae9ab0d071aa5a29c66fb8453d08e9559a658d7c450a82f2dd'
  })

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"
  depends_on 'composer' => :build

  def self.install
    system 'composer install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.cp_r Dir.pwd, "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/deployer-#{version}/bin/dep", "#{CREW_DEST_PREFIX}/bin/dep"
  end

  def self.postinstall
    puts
    puts "To get started, execute 'dep'".lightblue
    puts
  end
end
