class Command
  def self.create
    puts 'Example package names: libnvme, crew-profile-base'.lightblue
    name = gets('Enter the package name:').chomp.capitalize.tr('-', '_')
    puts 'Example package description: C Library for NVM Express on Linux.'.lightblue
    description = gets('Enter the package description:').chomp
    puts 'Example package homepage: https://github.com/linux-nvme/libnvme'.lightblue
    homepage = gets('Enter the package homepage:').chomp
    puts 'Example package version: v1.0-rc4'.lightblue
    version = gets('Enter the package version:').chomp
    puts 'Example package license: LGPL-2.1+'.lightblue
    license = gets('Enter the package license:').chomp
    puts 'Example package source_url: https://github.com/linux-nvme/libnvme/archive/refs/tags/v1.0-rc4.tar.gz'.lightblue
    source_url = gets('Enter the package source_url:').chomp
    puts 'Example package source_sha256: 82dc150c09e5e211d5200a37fabbbe25c69f5b0f22582956e51587a5a54463b5'.lightblue
    source_sha256 = gets('Enter the package source_sha256:').chomp
    puts 'Example package buildsystem: meson'.lightblue
    buildsystem = gets('Enter the package buildsystem:').chomp

    puts <<~EOF
      require "'buildsystems/#{buildsystem}'"

      class #{name} < #{buildsystem.capitalize}
        description "'#{description}'"
        homepage "'#{homepage}'"
        version "'#{version}'"
        license "'#{license}'"
        compatibility 'all'
        source_url "'#{source_url}'"
        source_sha256 "'#{source_sha256}'"
        binary_compression 'tar.zst'

        binary_sha256({
         aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
          armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
            i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
          x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
        })
      end
    EOF
  end
end
