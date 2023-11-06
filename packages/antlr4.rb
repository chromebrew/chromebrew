require 'package'

class Antlr4 < Package
  description 'ANTLR (ANother Tool for Language Recognition) is a powerful parser generator for reading, processing, executing, or translating structured text or binary files.'
  homepage 'https://www.antlr.org/'
  @_ver = '4.12.0'
  version "#{@_ver}-1"
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/antlr/antlr4/archive/4.12.0.tar.gz'
  source_sha256 '8b6050a2111a6bb6405cc5e9e7bca80c136548ac930e4b2c27566d1eb32f8aed'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/antlr4/4.12.0-1_armv7l/antlr4-4.12.0-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/antlr4/4.12.0-1_armv7l/antlr4-4.12.0-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/antlr4/4.12.0-1_i686/antlr4-4.12.0-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/antlr4/4.12.0-1_x86_64/antlr4-4.12.0-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80863f7d228af865b8e203940b20315281e8b4051368280995f9e58e29cfabbf',
     armv7l: '80863f7d228af865b8e203940b20315281e8b4051368280995f9e58e29cfabbf',
       i686: 'b06cc13d89c857d6c289b9a7e5db8746b25016d8f3ab869f1665724bbfa9a3d0',
     x86_64: '4bf4a263b746b86ff380a88e912747ebd96ee97ba38e63b2cdf2d10dff951b47'
  })

  depends_on 'openjdk11'
  reload_source

  def self.build
    @antlrenv = <<~ANTLR_EOF
      # ANTLR (ANother Tool for Language Recognition) configuration
      CLASSPATH=".:#{CREW_PREFIX}/share/antlr/antlr-#{@_ver}-complete.jar:$CLASSPATH"
      alias antlr4="java -jar #{CREW_PREFIX}/share/antlr/antlr-#{@_ver}-complete.jar"
      alias grun="java org.antlr.v4.gui.TestRig"
    ANTLR_EOF
    Dir.chdir 'runtime/Cpp' do
      system "cmake -B builddir #{CREW_CMAKE_OPTIONS} -G Ninja -DBUILD_GMOCK=OFF -DINSTALL_GTEST=OFF"
      system "#{CREW_NINJA} -C builddir"
    end
  end

  def self.install
    downloader "https://www.antlr.org/download/antlr-#{@_ver}-complete.jar",
               '88f18a2bfac0dde1009eda5c7dce358a52877faef7868f56223a5bcc15329e43'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/antlr"
    File.write("#{CREW_DEST_PREFIX}/etc/env.d/10-antlr4", @antlrenv)
    FileUtils.install "antlr-#{@_ver}-complete.jar", "#{CREW_DEST_PREFIX}/share/antlr", mode: 0o644
    Dir.chdir 'runtime/Cpp' do
      system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'antlr4' to get started.\n".lightblue
  end
end
