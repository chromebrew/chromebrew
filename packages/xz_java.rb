require 'package'

class Xz_java < Package
  description 'A complete implementation of XZ data de/compression in pure Java.'
  homepage 'https://tukaani.org/xz/java.html'
  version '1.12'
  license 'public-domain'
  compatibility 'all'
  source_url "https://tukaani.org/xz/xz-java-#{version}.zip"
  source_sha256 'd563ba12babaf977f02207c7e474ad41f8ca701efd35ff82abe26c54d66ab68d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d223ba1d3718968f132983e88f18cf0d2fb4bbeb5b310b0872d28448376623c',
     armv7l: '3d223ba1d3718968f132983e88f18cf0d2fb4bbeb5b310b0872d28448376623c',
       i686: '59afeb741d5acf09eab5054e4855d74df2400d891826cf66765ef629d130eb4b',
     x86_64: '5144ef2ad763781344ce5c3dfc4d3356538eacf4fb5259afacdbe5b6854641c6'
  })

  depends_on 'openjdk17'
  depends_on 'ant' => :build

  def self.build
    ENV['JAVA_HOME'] = CREW_PREFIX
    system 'ant'
    File.write 'lzma-enc', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/xz-java/LZMAEncDemo.jar "$@"
    EOF
    File.write 'lzma-dec', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/xz-java/LZMADecDemo.jar "$@"
    EOF
    File.write 'xz-enc', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/xz-java/XZEncDemo.jar "$@"
    EOF
    File.write 'xz-dec', <<~EOF
      #!/bin/bash
      java -jar #{CREW_PREFIX}/share/xz-java/XZDecDemo.jar "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xz-java"
    FileUtils.cp_r 'build/jar/.', "#{CREW_DEST_PREFIX}/share/xz-java/"
    FileUtils.install %w[lzma-enc lzma-dec xz-enc xz-dec], "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Use 'lzma-enc' or 'xz-enc' to encode/compress.
      Use 'lzma-dec' or 'xz-dec' to decode/decompress.
    EOM
  end
end
