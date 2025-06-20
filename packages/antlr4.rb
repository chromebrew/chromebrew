require 'package'

class Antlr4 < Package
  description 'ANTLR (ANother Tool for Language Recognition) is a powerful parser generator for reading, processing, executing, or translating structured text or binary files.'
  homepage 'https://www.antlr.org/'
  version '4.13.2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/antlr/antlr4/archive/4.13.2.tar.gz'
  source_sha256 '9f18272a9b32b622835a3365f850dd1063d60f5045fb1e12ce475ae6e18a35bb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80863f7d228af865b8e203940b20315281e8b4051368280995f9e58e29cfabbf',
     armv7l: '80863f7d228af865b8e203940b20315281e8b4051368280995f9e58e29cfabbf',
       i686: 'b06cc13d89c857d6c289b9a7e5db8746b25016d8f3ab869f1665724bbfa9a3d0',
     x86_64: '4bf4a263b746b86ff380a88e912747ebd96ee97ba38e63b2cdf2d10dff951b47'
  })

  depends_on 'openjdk11'
  print_source_bashrc

  def self.build
    Dir.chdir 'runtime/Cpp' do
      system "cmake -B builddir #{CREW_CMAKE_OPTIONS} -G Ninja -DBUILD_GMOCK=OFF -DINSTALL_GTEST=OFF"
      system "#{CREW_NINJA} -C builddir"
    end
  end

  def self.install
    downloader "https://www.antlr.org/download/antlr-#{version}-complete.jar",
               '88f18a2bfac0dde1009eda5c7dce358a52877faef7868f56223a5bcc15329e43'

    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/etc/env.d #{CREW_DEST_PREFIX}/share/antlr]

    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install", chdir: 'runtime/Cpp'
    FileUtils.install "antlr-#{version}-complete.jar", "#{CREW_DEST_PREFIX}/share/antlr", mode: 0o644

    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-antlr4", <<~ANTLR_EOF
      # ANTLR (ANother Tool for Language Recognition) configuration
      CLASSPATH=".:#{CREW_PREFIX}/share/antlr/antlr-#{version}-complete.jar:$CLASSPATH"
      alias antlr4="java -jar #{CREW_PREFIX}/share/antlr/antlr-#{version}-complete.jar"
      alias grun="java org.antlr.v4.gui.TestRig"
    ANTLR_EOF
  end

  def self.postinstall
    ExitMessage.add "\nType 'antlr4' to get started.\n".lightblue
  end
end
