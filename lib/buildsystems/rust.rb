require 'package'

class RUST < Package
  property :rust_options, :rust_release_profile, :rust_targets, :pre_rust_options, :rust_build_extras, :rust_install_extras

  def self.build
    rust_env =
      {
            BASH_ENV: "#{CREW_PREFIX}/etc/env.d/rust",
         CREW_LINKER: 'ld',
                  LD: 'ld',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil)
      }.transform_keys(&:to_s)

    puts 'Additional rust options being used:'.orange
    method_list = methods.grep(/rust_/).delete_if { |i| send(i).blank? }
    method_list.each do |method|
      puts "#{method}: #{send method}".orange
    end

    system rust_env, "bash -c \"rustup target add #{@rust_targets}\"" unless @rust_targets.to_s.empty?
    system rust_env, "bash -c \"#{@pre_rust_options} cargo fetch \
      --manifest-path Cargo.toml\""
    system rust_env, "bash -c \"#{@pre_rust_options} cargo build \
      --profile=#{@rust_release_profile.to_s.empty? ? 'release' : @rust_release_profile} \
      #{@rust_options} \
      --manifest-path Cargo.toml\""
    @rust_build_extras&.call
  end

  def self.install
    rust_env =
      {
            BASH_ENV: "#{CREW_PREFIX}/etc/env.d/rust",
         CREW_LINKER: 'ld',
                  LD: 'ld',
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil)
      }.transform_keys(&:to_s)

    system rust_env, "bash -c \"cargo install \
      --offline \
      --no-track \
      --path . \
      --root #{CREW_DEST_PREFIX}\""
    @rust_install_extras&.call
  end
end
