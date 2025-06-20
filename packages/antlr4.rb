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
    aarch64: 'e3fa17ad9cdc1edbafe5c3ba1ba9457c1655cabc1e2d5ec808f935b0fec4dc4d',
     armv7l: 'e3fa17ad9cdc1edbafe5c3ba1ba9457c1655cabc1e2d5ec808f935b0fec4dc4d',
       i686: '8773bedc562497079e48ac34dc07cd0f62c4017075f8b99f28d8743aebe9b205',
     x86_64: 'db2ddd5bda866b111fb06f648b0642f6bdd5c5dd50249b832b82e899d743d0ef'
  })

  depends_on 'openjdk11'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  print_source_bashrc

  def self.build
    Dir.chdir 'runtime/Cpp' do
      system "cmake -B builddir #{CREW_CMAKE_OPTIONS} -G Ninja -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DBUILD_GMOCK=OFF -DINSTALL_GTEST=OFF"
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
